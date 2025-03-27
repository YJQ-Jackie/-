#使用資料網址：
#老人福利機構：https://data.gov.tw/dataset/8572
#縣市三階段人口及扶養比(96)：https://www.ris.gov.tw/app/portal/346
#縣市經緯度：https://data.gov.tw/dataset/7442
#路徑"D:\\研究助理工作\\老人福利機構"

install.packages("sf")
library(sf)
library(magrittr)
library(readxl)
library(ggplot2)
library(dplyr)
install.packages("zip")
library(zip)

setwd(dir = "D:\\研究助理工作\\老人福利機構")
county_name <- c("臺北市","基隆市","新北市","連江縣","宜蘭縣","新竹市","新竹縣","桃園市","苗栗縣","臺中市","彰化縣","南投縣","嘉義市","嘉義縣","雲林縣","臺南市","高雄市","澎湖縣","金門縣","屏東縣","臺東縣","花蓮縣")
#行政地區資料zip解壓縮
unzip("mapdata202301070205.zip")


###各縣市老人福利機構名冊
for (county in county_name){
  data <- county %>% paste("老人福利機構名冊.csv" ,sep = "") %>% read.csv(header = TRUE, sep = ",", fileEncoding = "Big5")
  data$county <- county
  names(data)[names(data) == "電話區碼"] <- "電話"
  data$機構數 <- sum(nrow(data))
  if (county=="臺北市"){
    institution <- data
  } else {
    institution %<>% rbind(.,data)
  }
}
institution$區域別 <- institution$county
institution <- institution[,c("區域別","機構數")]
institution <- institution[!duplicated(institution),]


###96年-112年各地人口結構
total_people<-data.frame()
for (sh_num in 1:17){
  people <- read_excel("縣市三階段人口及扶養比(96).xls",sheet=sh_num)
  for (i in 1:ncol(people)){
    if (is.na(people[2,i])==TRUE){
      people[2,i] <- people[2,i-1]
    }
    if (is.na(people[2,i])==FALSE & is.na(people[3,i])==FALSE){
      colnames(people)[i] = paste(people[2,i],people[3,i])
    } else {
      colnames(people)[i] = people[2,i]
    }
  }
  colnames(people) %<>% gsub("　", "", .) %<>% gsub("   ", "", .) %<>% gsub("  ", "", .) %<>% gsub("  ", "", .)
  people$區域別 <- people$區域別 %>% sapply(., function(x) gsub("  ", "", x)) %>% sapply(., function(x) gsub("  ", "", x))
  people$year <- 113 - sh_num
  total_people <- rbind(total_people,people)
}
total_people <- total_people[(grepl("縣", total_people$區域別) | grepl("市", total_people$區域別))&!grepl("改制", total_people$區域別),]
total_people$區域別 <- sapply(total_people$區域別, function(x) gsub("  ", "", x))
total_people$區域別 <- sapply(total_people$區域別, function(x) gsub(" ", "", x))
total_people$`三階段年齡人口數 65+(萬人)` <- as.numeric(total_people$`三階段年齡人口數 65+`)/10000


###台灣地圖匯入
shp <- st_read(".//COUNTY_MOI_1090820.shp")
names(shp)[names(shp) == "COUNTYNAME"] <- "區域別"

merged_df <- total_people %>% merge(shp, by = "區域別", all = TRUE) %>% merge(institution, by = "區域別", all = TRUE)


#老年人口數
png("老年人口地圖.png")
merged_df %>% filter(year==112) %>% distinct(區域別, .keep_all = TRUE) %>% 
  ggplot(.)+
  geom_sf(aes(fill = as.numeric(`三階段年齡人口數 65+(萬人)`), geometry=`geometry`))+
  coord_sf(xlim = c(119, 123), ylim = c(21, 26))+
  scale_fill_gradient(low = "snow", high = "#56B1F7")+
  labs(title = "65歲以上人口數",
       x = "經度",
       y = "緯度",
       fill = "人數(萬)"
  )
dev.off()

#老年人口比例
png("老年人口比例地圖.png")
merged_df %>% filter(year==112) %>% distinct(區域別, .keep_all = TRUE) %>% 
  ggplot(.)+
  geom_sf(aes(fill = as.numeric(`年齡分配百分比 (%) 65+`), geometry=`geometry`))+
  coord_sf(xlim = c(119, 123), ylim = c(21, 26))+
  scale_fill_gradient(low = "snow", high = "#56B1F7")+
  labs(title = "65歲以上比例(%)",
       x = "經度",
       y = "緯度",
       fill = "比例(%)"
  )
dev.off()

#機構數
png("機構數地圖.png")
merged_df %>% distinct(區域別, .keep_all = TRUE) %>% ggplot(.)+
  geom_sf(aes(fill = as.numeric(`機構數`), geometry=`geometry`))+
  coord_sf(xlim = c(119, 123), ylim = c(21, 26))+
  scale_fill_gradient(low = "snow", high = "#56B1F7")+
  labs(title = "老人福利機構數量分布",
       x = "經度",
       y = "緯度",
       fill = "數量(間)"
  )
dev.off()

#高齡化程度趨勢
png("高齡化程度趨勢.png")
merged_df %>% 
  filter(區域別 %in% c("臺北市","新北市","臺中市","臺南市","高雄市","桃園市")) %>% 
  ggplot(., aes(x = year, y = as.numeric(`年齡分配百分比 (%) 65+`), color = `區域別`, group = 區域別)) +
  geom_line() +
  geom_point() +
  labs(title = "六都高齡化程度趨勢",
       x = "年份",
       y = "65歲以上比例(%)")
dev.off()

#機構數&高齡人口相關圖
png("機構數&高齡人口相關圖.png")
merged_df %>%
  filter(year==112) %>%
  ggplot(aes(x = as.numeric(`三階段年齡人口數 65+(萬人)`), y = `機構數`)) +
  geom_point() +
  geom_smooth(method = lm)+
  labs(title = "機構數及高齡人口相關性",
       x = "高齡人口數(萬人)",
       y = "機構數")
dev.off()

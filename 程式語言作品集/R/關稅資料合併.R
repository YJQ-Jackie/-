library(readxl)
library(magrittr)
library(dplyr)
library(writexl)
library(stringr)
library(tidyr)
library(readr) #存csv用
setwd(dir = "D:\\研究助理工作\\關稅")

total_tax <- data.frame()
y <- 1996
while (y<=2024){
  #zip_name <- paste(as.character(y),"_TL.xls.zip",sep="")
  #zip::unzip(zip_name)
  excel_name <- paste(as.character(y),"_TL.xls",sep="")
  tax_excel <- read_excel(excel_name,sheet="DutyDetails")
  total_tax <- rbind(total_tax,tax_excel)
  y <- y+1
}
TL_ind <- read_excel("T_8_1.xlsx") %>% select("HS_NO2","NOTE_cate","HS_NO","NOTE","產業別") 
TL_ind <- TL_ind[!duplicated(TL_ind), ]

total_tax$TL_num <- total_tax$TL %>% sapply(., function(x) gsub("'", "", x))
total_tax %<>% merge(TL_ind,by.x = "TL_num", by.y = "HS_NO", all.x = TRUE)
total_tax <- total_tax[order(total_tax$TL_num, total_tax$Year), ]
write_xlsx(total_tax, "total_tax.xlsx")


tariff <- read_excel("total_tax.xlsx")
tariff_25w <- tariff[1:250000,]
tariff_50w <- tariff[250001:500000,]
tariff_75w <- tariff[500001:750000,]
tariff_100w <- tariff[750001:nrow(tariff),]

write_xlsx(tariff_25w, "tariff_25w.xlsx")
write_xlsx(tariff_50w, "tariff_50w.xlsx")
write_xlsx(tariff_75w, "tariff_75w.xlsx")
write_xlsx(tariff_100w, "tariff_100w.xlsx")

tariff_excel <- read_excel("tariff.xlsx")
tariff_excel <- tariff_excel[tariff_excel$LEN=="8",] #刪掉1998的關稅資料(10碼)
write_xlsx(tariff_excel, "tariff_code8.xlsx")


tariff_c8 <- read_excel("tariff_code8.xlsx")
tariff_c8 %<>% 
  group_by(TL_num) %>% 
  arrange(產業別) %>% 
  mutate(產業別 = first(產業別)) %>% ungroup() %>%
  arrange(TL_num)
#write_xlsx(tariff_c8,"tariff_c8.xlsx")



#重新整理2碼&對照名稱
c8 <- read_excel("tariff_c8.xlsx")
c8$LEN <- NULL
c8$NOTE <- NULL
c8$NOTE_cate <- NULL
c8$HS_NO2 <- substr(c8$TL,1,2)
c8 %<>% merge(對照,by.x = "TL_num", by.y = "HS_NO", all.x = TRUE)
colnames(T) <- c("HS_NO", "NOTE_cate")
c8 %<>% merge(T,by.x = "HS_NO2", by.y = "HS_NO", all.x = TRUE)
c8 %<>%
  arrange(TL_num, Year) %>%
  select(TL_num, HS_NO2, NOTE_cate, Year, Description1, 產業別, NOTE, everything())
write_xlsx(c8,"tariff_1.xlsx")

#2019年抓回去
append2019 <- read_excel("2019_TL.xls",sheet="DutyDetails")
append2019$TL_num <- append2019$TL %>% sapply(., function(x) gsub("'", "", x))
append2019$HS_NO2 <- substr(append2019$TL_num,1,2)
append2019 %<>% merge(對照,by.x = "TL_num", by.y = "HS_NO", all.x = TRUE)
append2019 %<>% merge(HS_NO2,by.x = "HS_NO2", by.y = "HS_NO2", all.x = TRUE)
colnames(append2019) %<>% sapply(., function(x) gsub(" ", "", x)) %>% sapply(., function(x) gsub("/", "", x))

tariff_2 <- read_excel("tariff_1.xlsx")
tariff_2 <- tariff_2[!duplicated(tariff_2), ]
tariff_2 %<>% bind_rows(append2019) %>%
  group_by(TL_num) %>% 
  arrange(產業別) %>% 
  mutate(產業別 = first(產業別)) %>% ungroup() %>%
  arrange(TL_num, Year) %>% 
  select(TL_num, HS_NO2, NOTE_cate, Year, Description1, 產業別, NOTE, everything())


#write_xlsx(tariff_2,"tariff_2.xlsx")

code_num <- read_excel("tariff_2.xlsx")
code_num <- code_num$TL_num
code_num <- code_num[!duplicated(code_num)]
write_xlsx(data.frame(code_num), "code_num.xlsx")
code_num <- read_excel("code_num.xlsx")
#進出口資料堆疊(關務署)
data <- data.frame()
for (i in list.files(path = ".\\進出口額", full.names = TRUE)){
  data_i <- read_excel(i)
  data %<>% rbind(data_i)
}
data <- rename(data, Year = 日期, TL_num = 貨品號列)
data <- data[!duplicated(data),]
dta <- pivot_wider(data, names_from = 進出口別, values_from = `美元(千元)`)
dta$Year %<>% substr(.,1,3) %>% gsub("年", "",.) %>% as.numeric()
dta %<>% group_by(TL_num) %>% 
  select(TL_num, Year, `進口總值(含復進口)`, `出口總值(含復出口)`, everything()) %>%
  arrange(TL_num, Year)

write_xlsx(dta, ".\\進出口額\\台灣進口額.xlsx")

##########################
# #進出口資料堆疊(國貿署)
find_last <- function(haystack, word) {
  matches <- gregexpr(word, haystack)[[1]] #查找 word 在 haystack 中所有出現的位置
  if (length(matches) == 1 && matches == -1) {
    return(-1)  # 如果沒有找到匹配項，返回 -1
  }
  return(tail(matches, 1))  # 返回最後一個匹配的位置
}

Year <- c(as.character(1989:2023), "2024(01~05)")
data <- data.frame()
file_list <- list.files(path = ".\\進出口額(國貿署)", full.names = TRUE)
for (i in file_list){
  print(paste(which(file_list==i),"/",length(file_list)))
  if (grepl("貿易值表" ,i)){
    data_i <- read_excel(i) 
    colnames(data_i) <- c("年(月)","貿易總值金額(美元)","貿易總值增減比(%)","出口金額(美元)","出口金額增減比(%)","進口金額(美元)","進口金額增減比(%)","出/入超金額(美元)","出/入超金額增減比(%)")
    data_i$TL_num <- data_i[3,"年(月)"][[1]] %>% substr(7,14)
    data_i <- data_i[-c(1:7),] %>% filter(`年(月)` %in% Year)
    data %<>% rbind(data_i)
  }
}
data_i <- read_excel(".\\進出口額(國貿署)\\貿易值表 (193).xlsx") 
colnames(data_i) <- c("年(月)","貿易總值金額(美元)","貿易總值增減比(%)","出口金額(美元)","出口金額增減比(%)","進口金額(美元)","進口金額增減比(%)","出/入超金額(美元)","出/入超金額增減比(%)")
data_i$TL_num <- data_i[3,"年(月)"][[1]] %>% substr(7,14)
data_i <- data_i[-c(1:7),] %>% filter(`年(月)` %in% Year)
data %<>% rbind(data_i)


data1 <- data
data <- data1
data %<>% 
  distinct(.keep_all = TRUE) %>%
  mutate(across(everything(), ~ na_if(., "---"))) %>% 
  mutate(across(everything(), ~ gsub(",", "", .)))
write_xlsx(data, ".\\進出口額(國貿署)\\台灣進出口額1989_2024(1).xlsx")

##########################
TL_num_check <- data.frame(data$TL_num[!duplicated(data$TL_num)])
colnames(TL_num_check)
write_xlsx(data, ".\\進出口額(國貿署)\\code_check.xlsx")

##########################
# 出口關稅
total_import <- data.frame()
for (i in c("美國", "日本", "中國", "歐盟", "韓國", "香港")){
  print(i)
  file_name <- paste(".\\出口關稅\\",i,".xlsx", sep="")
  a <- read_excel(file_name)
  a <- a[-1,]
  a <- a %>%
    fill(年份, .direction = "down")
  a$國家 <- i
  a$`金額(美元)` <- NULL
  a$TL_num_n <- as.numeric(a$TL_num)
  a <- subset(a, !is.na(TL_num_n))
  print(sum(!is.na(a$貿易協定)))
  a$TL_num_n <- NULL
  a$外文貨名 <- NULL
  a$貿易協定 <- NULL
  a$`貿易協定 Ad val.` <- NULL
  a$`貿易協定 Non ad val.` <- NULL
  file_name <- paste(".\\出口關稅\\",i,"_.xlsx", sep="")
  a %<>% select(國家, TL_num, 年份, everything())
  #write_xlsx(a, file_name)
  total_import <- rbind(total_import,a)
}
import_pivot <- total_import %>% group_by(TL_num,年份) %>%
  pivot_wider( names_from = 國家, values_from = c("Ad val.","Non ad val.")) %>%
  arrange(TL_num, 年份)
#,"貿易協定","貿易協定 Ad val.","貿易協定 Non ad val."
import_pivot$TL_num <- as.character(import_pivot$TL_num)
fwrite(import_pivot, ".\\出口關稅\\出口關稅.csv", na="")
read_csv(".\\出口關稅\\出口關稅.csv")

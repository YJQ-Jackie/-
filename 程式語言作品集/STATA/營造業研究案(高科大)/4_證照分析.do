use "D:\營造業\1018攜出\license_data.dta", clear
replace year=year+1911
sort pno_name year
by pno_name year: egen total=sum(人數)
by pno_name year: keep if _n==_N
format total %12.0gc
drop male 人數

separate total, by(pno_name)
label var total1 下水道用戶排水設備配管
label var total2 下水道設施操作維護
label var total3 下水道設施操作維護－機電設備
label var total4 下水道設施操作維護－水質檢驗
label var total5 下水道設施操作維護－管渠系統
label var total6 下水道設施操作維護－處理系統
label var total7 冷凍空調裝修
label var total8 室內配線（屋內線路裝修）
label var total9 工業配線
label var total10 建築塗裝
label var total11 建築物室內裝修工程管理
label var total12 建築物室內設計
label var total13 建築製圖應用
label var total14 泥水
label var total15 泥水－砌磚
label var total16 泥水－粉刷
label var total17 泥水－面材舖貼
label var total18 混凝土
label var total19 測量
label var total20 測量－地籍測量
label var total21 測量－工程測量
label var total22 營建防水
label var total23 營建防水－塗膜系防水施工
label var total24 營建防水－填縫系防水施工
label var total25 營建防水－水泥系防水施工
label var total26 營建防水－烘烤系防水施工
label var total27 營建防水－薄片系防水施工
label var total28 營造工程管理
label var total29 自來水管配管
label var total30 裝潢木工
label var total31 變壓器裝修
label var total32 變電設備裝修
label var total33 輸電地下電纜裝修
label var total34 輸電架空線路裝修
label var total35 造園景觀
label var total36 配電線路裝修
label var total37 配電電纜裝修
label var total38 鋼筋
label var total39 鋼管施工架
label var total40 門窗木工

reshape wide total,i(pno_name) j(year)
forvalues i=2012/2022{
label var total`i' `i'
replace total`i'=0 if total`i'==.
}
label var pno_name 證照名稱
sort pno_name 
export excel using "D:\營造業\證照人數.xlsx", firstrow(varlabels) replace
/*
forvalue i = 1/40{
twoway line total`i' year
}
s
sort pno_name year
by pno_name: keep if _n==1
sort year
keep pno_name
duplicates drop
list
*/
cd "D:\營造業"

import excel "D:\研究助理工作\營造業\營造業課程分類.xlsx", sheet("Sheet1") firstrow clear
save 營造業課程分類.dta,replace
sort 課程大類 課程小類
by 課程大類 課程小類: keep if _n==_N
tab  課程小類 課程大類

import excel "D:\研究助理工作\營造業\營造業課程分類_工師.xlsx", sheet("Sheet1") firstrow clear
drop F G H I J K
save 營造業課程分類_工師.dta,replace

use "D:\研究助理工作\營造業\1018攜出\lesson_data.dta",clear
rename 參訓人數 人數
merge m:1 課程名稱 using 營造業課程分類_工師.dta
keep if _merge==3
tab year 課程大類
tab year 課程小類
order year 課程大類 課程小類 人員 

preserve
capture log close
log using log\課程.log,replace
gen n=1
sort year 課程小類 人員
by year 課程小類 人員: egen 小工開課數=sum(n)
*by year 課程小類 人員: keep if _n==_N
drop 性別
order year 課程大類 課程小類 人員 小工開課數
sort 課程大類 課程小類 人員 year

tab 課程小類 year if 人員=="工"
tab 課程小類 year if 人員=="師"
log close
sort year 課程小類
by year 課程小類: egen 小開課數=sum(n)
sort year 課程大類
by year 課程大類: egen 大開課數=sum(n)

restore

/*gen n=1
sort year 課程小類
by year 課程小類: egen 開課數=sum(n)
by 課程小類: tab year 開課數*/

sort year 課程小類 人員
by  year 課程小類 人員: egen 參訓人數=sum(人數)
keep 課程小類 課程大類 year 參訓人數 人員
duplicates drop
preserve
keep if 人員=="工"
reshape wide 參訓人數,i(課程大類 課程小類) j(year)
forvalues i=2015/2022{
label var 參訓人數`i' `i'
replace 參訓人數`i'=0 if 參訓人數`i'==.
}
export excel using "D:\研究助理工作\營造業\職訓人數.xlsx", sheet("工類") firstrow(varlabels)
restore
preserve
keep if 人員=="師"
reshape wide 參訓人數,i(課程大類 課程小類) j(year)
forvalues i=2015/2022{
label var 參訓人數`i' `i'
replace 參訓人數`i'=0 if 參訓人數`i'==.
}
export excel using "D:\研究助理工作\營造業\職訓人數.xlsx", sheet("師類") firstrow(varlabels)
restore

by  year 課程小類: egen 總參訓人數=sum(參訓人數)
keep 課程小類 課程大類 year 總參訓人數
duplicates drop
reshape wide 總參訓人數,i(課程大類 課程小類) j(year)
forvalues i=2015/2022{
label var 總參訓人數`i' `i'
replace 總參訓人數`i'=0 if 總參訓人數`i'==.
}
export excel using "D:\研究助理工作\營造業\職訓人數.xlsx", sheet("總計") firstrow(varlabels)

/*
*by  year 課程小類: keep if _n==1
*sort 課程小類
//開課數
tab 課程小類 year if 人員=="工"
tab 課程小類 year if 人員=="師"
drop 性別

sort 課程大類 year
by year 課程大類: egen 參訓人數=sum(人數)
by year 課程大類: keep if _n==1
by 課程大類: tab year 參訓人數


*/
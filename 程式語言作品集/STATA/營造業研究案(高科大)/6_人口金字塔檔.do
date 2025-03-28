clear
cd "D:\研究助理工作\營造業"

use "D:\研究助理工作\營造業\0908攜出\male_dage.dta",clear
//人口金字塔
drop if male==99
drop if part==1

label var year 年份
label var part 兼職
label var male 性別
label var age 平均年齡
label var n 總人數
label var foreign 移工比例
label var foreign_sum 移工總人數
label var dage_1 "19歲以下"
label var dage_2 "20-24歲"
label var dage_3 "25-29歲"
label var dage_4 "30-34歲"
label var dage_5 "35-39歲"
label var dage_6 "40-44歲"
label var dage_7 "45-49歲"
label var dage_8 "50-54歲"
label var dage_9 "55-59歲"
label var dage_10 "60-64歲"
label var dage_11 "65歲以上"

label define sex 0 "女" 1 "男"
label value male sex

tempfile male_dage_
save `male_dage_'

local x=2016
while `x' <=2022{
use "D:\研究助理工作\營造業\0908攜出\male_dage.dta",clear
disp "`x'"
keep if year==`x'
drop if male==99
drop if part==1
keep year male dage_*
reshape long dage_,i(year male) j(dage)
keep dage dage_ male
reshape wide dage_,i(dage) j(male)
gen year=`x'
tempfile pyramid_`x'
save `pyramid_`x''.dta,replace

local x=`x'+1
}

local x=2016
while `x' <=2021{
disp "`x'"
append using `pyramid_`x''.dta
local x=`x'+1
}
/*
label define range 1 "19歲以下" 2 "20-24歲" 3 "25-29歲" 4 "30-34歲" /*
*/5 "35-39歲" 6 "40-44歲" 7 "45-49歲" 8 "50-54歲" 9 "55-59歲" 10 "60-64歲" 11 "65歲以上"
label value dage range
*/
label var year 年份
label var dage 年齡層
label var dage_1 男
label var dage_0 女
order year dage dage_1 dage_0
sort year dage


save pyramid,replace
export excel using "D:\研究助理工作\營造業\人口金字塔.xlsx", firstrow(varlabels) replace


tostring dage,replace
replace dage="19歲以下" if dage=="1"
replace dage="20-24歲" if dage=="2"
replace dage="25-29歲" if dage=="3"
replace dage="30-34歲" if dage=="4"
replace dage="35-39歲" if dage=="5"
replace dage="40-44歲" if dage=="6"
replace dage="45-49歲" if dage=="7"
replace dage="50-54歲" if dage=="8"
replace dage="55-59歲" if dage=="9"
replace dage="60-64歲" if dage=="10"
replace dage="65歲以上" if dage=="11"

sort year dage
by year dage: gen total=dage_1+dage_0
foreach i in dage_1 dage_0 total{
seperate `i',by (year)
forvalues j = 2016/2022{
label var `i'`j' "`j'年"
format `i'`j' %12.0gc

}
}
twoway connected total2016 total2017 total2018 total2019 total2020 total2021 total2022 dage ,/*
*/ylab(0(40000)120000,angle(horizontal))  ytick(0(20000)120000) /*
*/xlab(1 "19歲以下" 2 "20-24歲" 3 "25-29歲" 4 "30-34歲" 5 "35-39歲" 6 "40-44歲" /*
*/7 "45-49歲" 8 "50-54歲" 9 "55-59歲" 10 "60-64歲" 11 "65歲以上") lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("年齡",width(30) height(6)size(3)) /*
*/title("各年齡層全職人數")subtitle("單位:人", position(1)size(3))
graph export "graph\dage_all.png", replace

twoway connected dage_02016 dage_02017 dage_02018 dage_02019 dage_02020 dage_02021 dage_02022 dage ,/*
*/ylab(0(10000)40000,angle(horizontal))  ytick(0(5000)40000) /*
*/xlab(1 "19歲以下" 2 "20-24歲" 3 "25-29歲" 4 "30-34歲" 5 "35-39歲" 6 "40-44歲" /*
*/7 "45-49歲" 8 "50-54歲" 9 "55-59歲" 10 "60-64歲" 11 "65歲以上") lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("年齡",width(30) height(6)size(3)) /*
*/title("各年齡層全職女性人數")subtitle("單位:人", position(1)size(3))
graph export "graph\dage_female.png", replace

twoway connected dage_12016 dage_12017 dage_12018 dage_12019 dage_12020 dage_12021 dage_12022 dage ,/*
*/ylab(0(20000)80000,angle(horizontal))  ytick(0(10000)80000) /*
*/xlab(1 "19歲以下" 2 "20-24歲" 3 "25-29歲" 4 "30-34歲" 5 "35-39歲" 6 "40-44歲" /*
*/7 "45-49歲" 8 "50-54歲" 9 "55-59歲" 10 "60-64歲" 11 "65歲以上") lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("年齡",width(30) height(6)size(3)) /*
*/title("各年齡層全職男性人數")subtitle("單位:人", position(1)size(3))
graph export "graph\dage_male.png", replace

//cate10
use "D:\研究助理工作\營造業\1030攜出\male_dage_ind_cate.dta", clear
keep if cate=="10"
sort times part
by times part: egen n_total=sum(n)
gen year=int(times)
sort year part cate times
by year part cate: keep if _n==_N
drop if male==99
drop if part==1

label var year 年份
label var part 兼職
label var male 性別
label var age 平均年齡
label var n 總人數
label var foreign 移工比例
label var foreign_sum 移工總人數
label var dage_1 "19歲以下"
label var dage_2 "20-24歲"
label var dage_3 "25-29歲"
label var dage_4 "30-34歲"
label var dage_5 "35-39歲"
label var dage_6 "40-44歲"
label var dage_7 "45-49歲"
label var dage_8 "50-54歲"
label var dage_9 "55-59歲"
label var dage_10 "60-64歲"
label var dage_11 "65歲以上"

label define sex 0 "女" 1 "男"
label value male sex
sort times male
by times male: keep if _n==_N

tempfile male_dage_
save `male_dage_'

local x=2016
while `x' <=2022{
use "D:\研究助理工作\營造業\1030攜出\male_dage_ind_cate.dta", clear
disp "`x'"
keep if cate=="10"
gen year=int(times)
sort year part male ind_small times
by year part male ind_small: keep if _n==_N
forvalues y=1/11{
by year part male: egen t_dage_`y'=sum(dage_`y')
}
sort year part male times
by year part male: keep if _n==_N
keep if year==`x'
drop if male==99
drop if part==1
keep year male t_dage_*
reshape long t_dage_,i(year male) j(dage)
keep dage t_dage_ male
reshape wide t_dage_,i(dage) j(male)
gen year=`x'
tempfile pyramid_`x'
save `pyramid_`x''.dta,replace

local x=`x'+1
}

local x=2016
while `x' <=2021{
disp "`x'"
append using `pyramid_`x''.dta
local x=`x'+1
}

label define range 1 "19歲以下" 2 "20-24歲" 3 "25-29歲" 4 "30-34歲" /*
*/5 "35-39歲" 6 "40-44歲" 7 "45-49歲" 8 "50-54歲" 9 "55-59歲" 10 "60-64歲" 11 "65歲以上"
label value dage range

label var year 年份
label var dage 年齡層
label var t_dage_1 男
label var t_dage_0 女
order year dage t_dage_1 t_dage_0
sort year dage

save pyramid_cate10,replace
export excel using "D:\研究助理工作\營造業\人口金字塔_cate10.xlsx", firstrow(varlabels) replace


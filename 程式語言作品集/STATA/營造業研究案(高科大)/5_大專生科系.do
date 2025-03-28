cd "D:\研究助理工作\營造業\graph"
use "D:\研究助理工作\營造業\grad.dta",clear

keep if strmatch(科系名稱,"*建築*")==1|strmatch(科系名稱,"*土木*")==1|/*
*/strmatch(科系名稱,"*景觀*")==1|strmatch(科系名稱,"*園藝*")==1|strmatch(科系名稱,"*營建*")==1
gen 科系類別=""
replace 科系類別="建築與建築設計類別" if strmatch(科系名稱,"*建築*")==1
replace 科系類別="土木工程類別" if strmatch(科系名稱,"*土木*")==1
replace 科系類別="景觀設計類別" if strmatch(科系名稱,"*景觀*")==1|strmatch(科系名稱,"*園藝*")==1
replace 科系類別="營建工程與管理類別" if strmatch(科系名稱,"*營建*")==1|strmatch(科系名稱,"*營建管理*")==1
replace 學制名稱="二專" if strmatch(學制名稱,"*二專*")==1
replace 學制名稱="二技" if strmatch(學制名稱,"*二技*")==1
replace 學制名稱="五專" if strmatch(學制名稱,"*五專*")==1
replace 學制名稱="四技" if strmatch(學制名稱,"*四技*")==1
replace 學制名稱="學士" if strmatch(學制名稱,"*學士*")==1
replace 學制名稱="碩士" if strmatch(學制名稱,"*碩士*")==1
replace 學制名稱="博士" if strmatch(學制名稱,"*博士*")==1
replace 學制名稱="學士後" if strmatch(學制名稱,"*學士後*")==1
sort 科系名稱 學制名稱
by 科系名稱 學制名稱:keep if _n==_N
drop 性別 n 畢業學年
export excel using "D:\研究助理工作\營造業\grad.xlsx",firstrow(varlabels) replace
import excel "D:\研究助理工作\營造業\grad.xlsx", sheet("Sheet1") firstrow clear
sort 科系名稱
by 科系名稱: keep if _n==_N
save grad_cate.dta,replace

gen name=""
replace name=科系名稱
drop 科系名稱
rename name 科系名稱
merge m:1 科系名稱 using grad_cate.dta
keep if _merge==3
drop _merge
gen 學制類別=""
replace 學制類別="二專" if strmatch(學制名稱,"*二專*")==1
replace 學制類別="二技" if strmatch(學制名稱,"*二技*")==1
replace 學制類別="五專" if strmatch(學制名稱,"*五專*")==1
replace 學制類別="四技" if strmatch(學制名稱,"*四技*")==1
replace 學制類別="學士" if strmatch(學制名稱,"*學士*")==1
replace 學制類別="碩士" if strmatch(學制名稱,"*碩士*")==1
replace 學制類別="博士" if strmatch(學制名稱,"*博士*")==1
replace 學制類別="學士後" if strmatch(學制名稱,"*學士後*")==1
sort 畢業學年 學制類別 科系類別 性別
by 畢業學年 學制類別 科系類別 性別: egen 人數=sum(n)
by 畢業學年 學制類別 科系類別: egen 總人數=sum(n)
sort 畢業學年 科系類別
by 畢業學年 科系類別: egen 總人數_不分學制=sum(n)
sort 畢業學年 科系類別
by 畢業學年: egen 總人數_不分類=sum(n)
sort 畢業學年 學制類別 科系類別 性別
by 畢業學年 學制類別 科系類別 性別: keep if _n==_N

foreach i in 人數 總人數 總人數_不分學制{
format `i' %12.0gc
}
foreach i in 人數 總人數 總人數_不分學制{
separate `i', by (科系類別)
label var `i'1 土木、營建工程類
label var `i'2 建築與建築設計類
label var `i'3 景觀設計類
}

preserve
sort 畢業學年
by 畢業學年 : keep if _n==_N
twoway connected 總人數_不分類 畢業學年,/*
*/ylab(6000(500)8000,angle(horizontal))  ytick(6000(100)8000) /*
*/xlab(105(1)109) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("畢業人數") /*
*/xtitle("畢業學年",width(30) height(6)size(3)) /*
*/title("畢業人數")subtitle("單位:人", position(1)size(3))
graph export "grad_stu_total.png", replace
restore

preserve
sort 畢業學年 科系類別
by 畢業學年 科系類別: keep if _n==_N
twoway connected 總人數_不分學制1 總人數_不分學制2 總人數_不分學制3 畢業學年,/*
*/ylab(1000(1000)5000,angle(horizontal))  ytick(1000(500)5000) /*
*/xlab(105(1)109) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("畢業人數") /*
*/xtitle("畢業學年",width(30) height(6)size(3)) /*
*/title("畢業人數")subtitle("單位:人", position(1)size(3))
graph export "grad_stu_.png", replace
restore

preserve
keep if 學制類別=="學士"
sort 畢業學年 科系類別
by 畢業學年 科系類別: keep if _n==_N
twoway connected 總人數1 總人數2 總人數3 畢業學年,/*
*/ylab(500(500)1500,angle(horizontal))  ytick(500(100)1500) /*
*/xlab(105(1)109) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("畢業人數") /*
*/xtitle("畢業學年",width(30) height(6)size(3)) /*
*/title("畢業人數_學士")subtitle("單位:人", position(1)size(3))
graph export "grad_stu_學士.png", replace
restore

preserve
keep if 學制類別=="碩士"
sort 畢業學年 科系類別
by 畢業學年 科系類別: keep if _n==_N
twoway connected 總人數1 總人數2 總人數3 畢業學年,/*
*/ylab(0(500)1500,angle(horizontal))  ytick(0(100)1500) /*
*/xlab(105(1)109) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("畢業人數") /*
*/xtitle("畢業學年",width(30) height(6)size(3)) /*
*/title("畢業人數_碩士")subtitle("單位:人", position(1)size(3))
graph export "grad_stu_碩.png", replace
restore

preserve
keep if 學制類別=="博士"
sort 畢業學年 科系類別
by 畢業學年 科系類別: keep if _n==_N
twoway connected 總人數1 總人數2 總人數3 畢業學年,/*
*/ylab(0(50)100,angle(horizontal))  ytick(0(10)100) /*
*/xlab(105(1)109) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("畢業人數") /*
*/xtitle("畢業學年",width(30) height(6)size(3)) /*
*/title("畢業人數_博士")subtitle("單位:人", position(1)size(3))
graph export "grad_stu_博士.png", replace
restore

preserve
keep if 學制類別=="二專"
sort 畢業學年 科系類別
by 畢業學年 科系類別: keep if _n==_N
twoway connected 總人數1 總人數2 總人數3 畢業學年,/*
*/ylab(0(50)100,angle(horizontal))  ytick(0(10)100) /*
*/xlab(105(1)109) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("畢業人數") /*
*/xtitle("畢業學年",width(30) height(6)size(3)) /*
*/title("畢業人數_二專")subtitle("單位:人", position(1)size(3))
graph export "grad_stu_二專.png", replace
restore

preserve
keep if 學制類別=="五專"
sort 畢業學年 科系類別
by 畢業學年 科系類別: keep if _n==_N
twoway connected 總人數1 總人數2 總人數3 畢業學年,/*
*/ylab(0(50)100,angle(horizontal))  ytick(0(10)100) /*
*/xlab(105(1)109) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("畢業人數") /*
*/xtitle("畢業學年",width(30) height(6)size(3)) /*
*/title("畢業人數_五專")subtitle("單位:人", position(1)size(3))
graph export "grad_stu_五專.png", replace
restore

preserve
keep if 學制類別=="二技"
sort 畢業學年 科系類別
by 畢業學年 科系類別: keep if _n==_N
twoway connected 總人數1 總人數2 總人數3 畢業學年,/*
*/ylab(0(100)300,angle(horizontal))  ytick(0(50)300) /*
*/xlab(105(1)109) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("畢業人數") /*
*/xtitle("畢業學年",width(30) height(6)size(3)) /*
*/title("畢業人數_二技")subtitle("單位:人", position(1)size(3))
graph export "grad_stu_二技.png", replace
restore

preserve
keep if 學制類別=="四技"
sort 畢業學年 科系類別
by 畢業學年 科系類別: keep if _n==_N
twoway connected 總人數1 總人數2 總人數3 畢業學年,/*
*/ylab(0(500)1500,angle(horizontal))  ytick(0(100)1500) /*
*/xlab(105(1)109) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("畢業人數") /*
*/xtitle("畢業學年",width(30) height(6)size(3)) /*
*/title("畢業人數_四技")subtitle("單位:人", position(1)size(3))
graph export "grad_stu_四技.png", replace
restore

preserve
keep if 學制類別=="學士後"
sort 畢業學年 科系類別
by 畢業學年 科系類別: keep if _n==_N
twoway connected 總人數1 總人數2 總人數3 畢業學年,/*
*/ylab(0(50)100,angle(horizontal))  ytick(0(10)100) /*
*/xlab(105(1)109) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("畢業人數") /*
*/xtitle("畢業學年",width(30) height(6)size(3)) /*
*/title("畢業人數_學士後")subtitle("單位:人", position(1)size(3))
graph export "grad_stu_學士後.png", replace
restore

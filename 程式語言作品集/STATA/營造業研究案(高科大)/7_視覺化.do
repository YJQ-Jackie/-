cd D:\研究助理工作\營造業\graph

use "D:\研究助理工作\營造業\0925攜出\emp_t.dta",clear
foreach i in n foreign_sum{
format `i' %12.0gc
}
//全、兼職人數
separate n, by(part)
label var n0 全職人數
label var n1 兼職人數

preserve
keep if part==1
keep times n
ren (times n) (時間 就業人數)
export excel using D:\研究助理工作\營造業\兼職人數.xlsx ,firstrow(var)
restore

preserve
keep if part==0
keep times n foreign foreign_sum
ren (times n foreign foreign_sum) (時間 就業人數 移工比例 移工人數)
export excel using D:\研究助理工作\營造業\全職人數.xlsx ,firstrow(var)
restore

twoway line n0 times,/*
*/ylab(700000(50000)800000,angle(horizontal))  ytick(700000(10000)800000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("全職人數")subtitle("單位:人", position(1)size(3))
graph export "femp.png", replace

twoway line n1 times,/*
*/ylab(10000(5000)30000,angle(horizontal))  ytick(10000(2500)30000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("兼職人數")subtitle("單位:人", position(1)size(3))
graph export "pemp.png", replace

//移工全、兼職人數
separate foreign_sum, by(part)
label var foreign_sum0 全職人數
label var foreign_sum1 兼職人數

twoway line foreign_sum0 times,/*
*/ylab(10000(5000)30000,angle(horizontal))  ytick(10000(2500)30000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("移工全職人數")subtitle("單位:人", position(1)size(3))
graph export "femp_fore.png", replace

twoway line foreign_sum1 times,/*
*/ylab(0(100)300,angle(horizontal))  ytick(0(50)300) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("移工兼職人數")subtitle("單位:人", position(1)size(3))
graph export "pemp_fore.png", replace

//全、兼職移工占比
separate foreign, by(part)
label var foreign0 全職移工占比
label var foreign1 兼職移工占比

twoway line foreign0 times,/*
*/ylab(0(0.01)0.05,angle(horizontal))  ytick(0(0.005)0.05) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("比例") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("移工占比")
graph export "femp_fpercent.png", replace

twoway line foreign1 times,/*
*/ylab(0(0.01)0.05,angle(horizontal))  ytick(0(0.005)0.05) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("比例") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("移工占比_兼職")
graph export "pemp_fpercent.png", replace

*********************************************
use "D:\研究助理工作\營造業\0925攜出\male_dage_t.dta", clear
foreach i in n foreign_sum{
format `i' %12.0gc
}

preserve
keep if part==1
label define mm 0 "女性" 1 "男性"
label value male mm
drop if male==99
keep times n male
sort times male
order times male n 
ren (times n male) (時間 就業人數 性別)
export excel using D:\研究助理工作\營造業\男女性兼職人數.xlsx ,firstrow(var) replace
restore

preserve
keep if part==0
label define mm 0 "女性" 1 "男性"
label value male mm
drop if male==99
keep times n male foreign_sum
sort times male
order times male n foreign_sum
ren (times n male foreign_sum) (時間 就業人數 性別 移工人數)
export excel using D:\研究助理工作\營造業\男女性全職人數.xlsx ,firstrow(var) replace
restore

//全、兼職男女人數
separate n, by (part)
separate n0, by (male)
label var n00 女性全職人數
label var n01 男性全職人數
separate n1, by (male)
label var n10 女性兼職人數
label var n11 男性兼職人數

twoway line n00 n01 times,/*
*/ylab(200000(100000)600000,angle(horizontal))  ytick(200000(50000)600000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("全職人數")subtitle("單位:人", position(1)size(3))
graph export "femp_sex.png", replace

twoway line n10 n11 times,/*
*/ylab(0(5000)20000,angle(horizontal))  ytick(0(1000)20000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("兼職人數")subtitle("單位:人", position(1)size(3))
graph export "pemp_sex.png", replace

//全、兼職移工男女人數
separate foreign_sum, by (part)
separate foreign_sum0, by (male)
separate foreign_sum1, by (male)
label var foreign_sum00 女性移工全職人數
label var foreign_sum01 男性移工全職人數
label var foreign_sum10 女性移工兼職人數
label var foreign_sum11 男性移工兼職人數

twoway line foreign_sum00 foreign_sum01 times,/*
*/ylab(0(5000)15000,angle(horizontal))  ytick(0(1000)15000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("移工全職人數")subtitle("單位:人", position(1)size(3))
graph export "femp_fore_sex.png", replace

twoway line foreign_sum10 foreign_sum11 times,/*
*/ylab(0(100)200,angle(horizontal))  ytick(0(50)200) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("移工兼職人數")subtitle("單位:人", position(1)size(3))
graph export "pemp_fore_sex.png", replace

*********************************************
use "D:\研究助理工作\營造業\0925攜出\emp_ind_t.dta",clear
foreach i in n foreign_sum{
format `i' %12.0gc
}
preserve
keep if part==1
keep times n ind_small
ren (times n ind_small) (時間 就業人數 業別)
export excel using D:\研究助理工作\營造業\各業別兼職人數.xlsx ,firstrow(var) replace
restore

preserve
keep if part==0
keep times n foreign ind_small foreign_sum
ren (times n foreign ind_small foreign_sum) (時間 就業人數 移工比例 業別 移工人數)
export excel using D:\研究助理工作\營造業\各業別全職人數.xlsx ,firstrow(var) replace
restore

//細業別全、兼職人數
foreach i in n foreign_sum foreign{
separate `i', by(part)
label var `i'0 全職人數
label var `i'1 兼職人數
}
foreach j in n foreign_sum foreign{
foreach i in 0 1{
separate `j'`i', by(ind_small)
label var `j'`i'1 建築工程業
label var `j'`i'2 道路工程業
label var `j'`i'3 公用事業設施工程業
label var `j'`i'4 其他土木工程業
label var `j'`i'5 整地、基礎及結構工程業
label var `j'`i'6 庭園景觀工程業
label var `j'`i'7 機電、電信及電路設備安裝業
label var `j'`i'8 冷凍、空調及管道工程業
label var `j'`i'9 其他建築設備安裝業
label var `j'`i'10 建物完工裝修工程業
label var `j'`i'11 其他專門營造業
label var `j'`i'12 建築服務業
label var `j'`i'13 工程服務及相關技術顧問業
label var `j'`i'14 營造用機械設備租賃業
}
}
twoway line n01 n04 n07 n010 times,/*
*/ylab(100000(50000)200000,angle(horizontal))  ytick(100000(10000)200000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("全職人數_細業別")subtitle("單位:人", position(1)size(3))
graph export "femp_ind1.png", replace

twoway line n08 n011 n013 times,/*
*/ylab(20000(10000)60000,angle(horizontal))  ytick(20000(5000)60000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("全職人數_細業別")subtitle("單位:人", position(1)size(3))
graph export "femp_ind2.png", replace

twoway line n02 n03 n05 n06 n09 n012 n014 times,/*
*/ylab(0(5000)10000,angle(horizontal))  ytick(0(1000)10000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("全職人數_細業別")subtitle("單位:人", position(1)size(3))
graph export "femp_ind3.png", replace

twoway line  n14 n17 n18 n110 n111  times,/*
*/ylab(0(2000)8000,angle(horizontal))  ytick(0(1000)8000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("兼職人數_細業別")subtitle("單位:人", position(1)size(3))
graph export "pemp_ind1.png", replace

twoway line n11 n16 n113 times,/*
*/ylab(0(1000)3000,angle(horizontal))  ytick(0(500)3000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("兼職人數_細業別")subtitle("單位:人", position(1)size(3))
graph export "pemp_ind2.png", replace

twoway line n12 n13 n15  n19 n112 n114 times,/*
*/ylab(0(500)1000,angle(horizontal))  ytick(0(100)1000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("兼職人數_細業別")subtitle("單位:人", position(1)size(3))
graph export "pemp_ind3.png", replace

//細業別移工全、兼職人數
twoway line foreign_sum01 foreign_sum04 foreign_sum07 foreign_sum010 times,/*
*/ylab(0(5000)15000,angle(horizontal))  ytick(0(1000)15000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("移工全職人數_細業別")subtitle("單位:人", position(1)size(3))
graph export "femp_fore_ind1.png", replace

twoway line foreign_sum08 foreign_sum011 foreign_sum013 times,/*
*/ylab(0(5000)15000,angle(horizontal))  ytick(0(1000)15000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("移工全職人數_細業別")subtitle("單位:人", position(1)size(3))
graph export "femp_fore_ind2.png", replace

twoway line foreign_sum02 foreign_sum03 foreign_sum05 foreign_sum06 foreign_sum09 foreign_sum012 foreign_sum014 times,/*
*/ylab(0(5000)15000,angle(horizontal))  ytick(0(1000)15000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("移工全職人數_細業別")subtitle("單位:人", position(1)size(3))
graph export "femp_fore_ind3.png", replace

twoway line foreign_sum11 foreign_sum14 foreign_sum17 foreign_sum110 times,/*
*/ylab(0(1000)5000,angle(horizontal))  ytick(0(500)5000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("移工兼職人數_細業別")subtitle("單位:人", position(1)size(3))
graph export "pemp_fore_ind1.png", replace

twoway line foreign_sum18 foreign_sum111 foreign_sum113 times,/*
*/ylab(0(1000)5000,angle(horizontal))  ytick(0(500)5000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("移工兼職人數_細業別")subtitle("單位:人", position(1)size(3))
graph export "pemp_fore_ind2.png", replace

twoway line foreign_sum12 foreign_sum13 foreign_sum16 foreign_sum19 foreign_sum112 foreign_sum114 times,/*
*/ylab(0(1000)5000,angle(horizontal))  ytick(0(500)5000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("移工兼職人數_細業別")subtitle("單位:人", position(1)size(3))
graph export "pemp_fore_ind3.png", replace

//細業別移工占比
twoway line foreign01 foreign02 foreign03 foreign04 foreign05 times,/*
*/ylab(0(0.05)0.1,angle(horizontal))  ytick(0(0.01)0.1) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("比例") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("全職移工占比_細業別")
graph export "femp_fpercent_ind1.png", replace

twoway line foreign06 foreign07 foreign08 foreign09 foreign010 times,/*
*/ylab(0(0.05)0.1,angle(horizontal))  ytick(0(0.01)0.1) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("比例") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("全職移工占比_細業別")
graph export "femp_fpercent_ind2.png", replace

twoway line foreign011 foreign012 foreign013 foreign014 times,/*
*/ylab(0(0.05)0.1,angle(horizontal))  ytick(0(0.01)0.1) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("比例") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("全職移工占比_細業別")
graph export "femp_fpercent_ind3.png", replace

*********************************************
use "D:\研究助理工作\營造業\0925攜出\male_dage_ind_t.dta",clear
foreach i in n foreign_sum{
format `i' %12.0gc
}

foreach i in n foreign_sum{
separate `i', by(part)
label var `i'0 全職人數
label var `i'1 兼職人數
}
foreach j in n foreign_sum{
foreach i in 0 1{
separate `j'`i', by (male)
foreach k in 0 1{
separate `j'`i'`k', by(ind_small)
label var `j'`i'`k'1 建築工程業
label var `j'`i'`k'2 道路工程業
label var `j'`i'`k'3 公用事業設施工程業
label var `j'`i'`k'4 其他土木工程業
label var `j'`i'`k'5 整地、基礎及結構工程業
label var `j'`i'`k'6 庭園景觀工程業
label var `j'`i'`k'7 機電、電信及電路設備安裝業
label var `j'`i'`k'8 冷凍、空調及管道工程業
label var `j'`i'`k'9 其他建築設備安裝業
label var `j'`i'`k'10 建物完工裝修工程業
label var `j'`i'`k'11 其他專門營造業
label var `j'`i'`k'12 建築服務業
label var `j'`i'`k'13 工程服務及相關技術顧問業
label var `j'`i'`k'14 營造用機械設備租賃業
}
}
}
//女性全職人數_細業別
twoway line n001 n004 n007 n0010 times,/*
*/ylab(20000(20000)80000,angle(horizontal))  ytick(20000(10000)80000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("女性全職人數_細業別")subtitle("單位:人", position(1)size(3))
graph export "femp_female_ind1.png", replace

twoway line n008 n0011 n0013 times,/*
*/ylab(0(10000)30000,angle(horizontal))  ytick(0(5000)30000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("女性全職人數_細業別")subtitle("單位:人", position(1)size(3))
graph export "femp_female_ind2.png", replace

twoway line n002 n003 n005 n006 n009 n0012 n0014 times,/*
*/ylab(0(5000)10000,angle(horizontal))  ytick(0(1000)10000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("女性全職人數_細業別")subtitle("單位:人", position(1)size(3))
graph export "femp_female_ind3.png", replace

//男性全職人數_細業別
twoway line n011 n014 n017 n0110 times,/*
*/ylab(60000(20000)160000,angle(horizontal))  ytick(60000(10000)160000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("男性全職人數_細業別")subtitle("單位:人", position(1)size(3))
graph export "femp_male_ind1.png", replace

twoway line n018 n0111 n0113 times,/*
*/ylab(20000(10000)40000,angle(horizontal))  ytick(20000(5000)40000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("男性全職人數_細業別")subtitle("單位:人", position(1)size(3))
graph export "femp_male_ind2.png", replace

twoway line n012 n013 n015 n016 n019 n0112 n0114 times,/*
*/ylab(0(5000)10000,angle(horizontal))  ytick(0(1000)10000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("男性全職人數_細業別")subtitle("單位:人", position(1)size(3))
graph export "femp_male_ind3.png", replace

//男性兼職人數
twoway line  n114 n117 n118 n1110 times,/*
*/ylab(0(5000)10000,angle(horizontal))  ytick(0(1000)10000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("男性兼職人數_細業別")subtitle("單位:人", position(1)size(3))
graph export "pemp_male_ind1.png", replace

twoway line n116 n1111 n1113 times,/*
*/ylab(0(5000)10000,angle(horizontal))  ytick(0(1000)10000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("男性兼職人數_細業別")subtitle("單位:人", position(1)size(3))
graph export "pemp_male_ind2.png", replace

twoway line n111 n112 n113 n115  n119 n1112 n1114 times,/*
*/ylab(0(5000)10000,angle(horizontal))  ytick(0(1000)10000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("男性兼職人數_細業別")subtitle("單位:人", position(1)size(3))
graph export "pemp_male_ind3.png", replace

//女性兼職人數
twoway line  n104 n107 n108 n1010 times,/*
*/ylab(0(5000)10000,angle(horizontal))  ytick(0(1000)10000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("女性兼職人數_細業別")subtitle("單位:人", position(1)size(3))
graph export "pemp_female_ind1.png", replace

twoway line n106 n1011 n1013 times,/*
*/ylab(0(5000)10000,angle(horizontal))  ytick(0(1000)10000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("女性兼職人數_細業別")subtitle("單位:人", position(1)size(3))
graph export "pemp_female_ind2.png", replace

twoway line n101 n102 n103 n105 n109 n1012 n1014 times,/*
*/ylab(0(5000)10000,angle(horizontal))  ytick(0(1000)10000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("女性兼職人數_細業別")subtitle("單位:人", position(1)size(3))
graph export "pemp_female_ind3.png", replace

*********************************************
//投保單位檔
use "D:\研究助理工作\營造業\0908攜出\lb_insu_cate.dta", clear
sort year
forvalues i = 1/6{
by year: egen total_cate`i'=sum(insu_cate_`i')
format total_cate`i' %12.0gc

}
gen total_cate7=total_cate3+total_cate6
label var total_cate1  產業勞工及交通公用事業之員工
label var total_cate2  職業工會
label var total_cate3  政府機關及公私立學校之員工
label var total_cate4  公司、行號之員工
label var total_cate5  自願投保者
label var total_cate6  新聞、文化、公益及合作事業之員工
label var total_cate7  其他

preserve
by year: keep if _n==1
export excel using "D:\研究助理工作\營造業\投保類型.xlsx", firstrow(varlabels) replace
twoway connected total_cate1 total_cate4 year,/*
*/ylab(10000(10000)50000,angle(horizontal))  ytick(10000(5000)50000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("投保類型")subtitle("單位:間", position(1)size(3))
graph export "insucate.png", replace

/*twoway connected total_cate1 total_cate2 total_cate3 total_cate4 total_cate5 total_cate6 year,/*
*/ylab(0(10000)50000,angle(horizontal))  ytick(0(5000)50000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("投保類型")subtitle("單位:間", position(1)size(3))
*/

twoway connected total_cate2 total_cate5 year,/*
*/ylab(0(1000)4000,angle(horizontal))  ytick(0(1000)4000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("投保類型")subtitle("單位:間", position(1)size(3))
graph export "insucate2.png", replace

restore


forvalue i = 1/6{
separate insu_cate_`i', by (ind_small)
}
forvalue j = 1/14{
label var insu_cate_1`j'  產業勞工及交通公用事業之員工
label var insu_cate_2`j'  職業工會
label var insu_cate_3`j'  政府機關及公私立學校之員工
label var insu_cate_4`j'  公司、行號之員工
label var insu_cate_5`j'  自願投保者
label var insu_cate_6`j'  新聞、文化、公益及合作事業之員工
}

twoway connected insu_cate_11 insu_cate_21 insu_cate_31 insu_cate_41 insu_cate_51 insu_cate_61 year,/*
*/ylab(0(500)2000,angle(horizontal))  ytick(0(100)2000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("建築工程業_投保類型")subtitle("單位:間", position(1)size(3))
graph export "insucate1.png", replace

twoway connected insu_cate_12 insu_cate_22 insu_cate_32 insu_cate_42 insu_cate_52 insu_cate_62 year,/*
*/ylab(0(500)2000,angle(horizontal))  ytick(0(100)2000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("道路工程業_投保類型")subtitle("單位:間", position(1)size(3))
graph export "insucate2.png", replace

twoway connected insu_cate_13 insu_cate_23 insu_cate_33 insu_cate_43 insu_cate_53 insu_cate_63 year,/*
*/ylab(0(500)2000,angle(horizontal))  ytick(0(100)2000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("公用事業設施工程業_投保類型")subtitle("單位:間", position(1)size(3))
graph export "insucate3.png", replace

twoway connected insu_cate_14 insu_cate_24 insu_cate_34 insu_cate_44 insu_cate_54 insu_cate_64 year,/*
*/ylab(0(500)2000,angle(horizontal))  ytick(0(100)2000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("其他土木工程業_投保類型")subtitle("單位:間", position(1)size(3))
graph export "insucate4.png", replace

twoway connected insu_cate_15 insu_cate_25 insu_cate_35 insu_cate_45 insu_cate_55 insu_cate_65 year,/*
*/ylab(0(500)2000,angle(horizontal))  ytick(0(100)2000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("整地、基礎及結構工程業_投保類型")subtitle("單位:間", position(1)size(3))
graph export "insucate5.png", replace

twoway connected insu_cate_16 insu_cate_26 insu_cate_36 insu_cate_46 insu_cate_56 insu_cate_66 year,/*
*/ylab(0(500)2000,angle(horizontal))  ytick(0(100)2000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("庭園景觀工程業_投保類型")subtitle("單位:間", position(1)size(3))
graph export "insucate6.png", replace

twoway connected insu_cate_17 insu_cate_27 insu_cate_37 insu_cate_47 insu_cate_57 insu_cate_67 year,/*
*/ylab(0(500)2000,angle(horizontal))  ytick(0(100)2000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("機電、電信及電路設備安裝業_投保類型")subtitle("單位:間", position(1)size(3))
graph export "insucate7.png", replace

twoway connected insu_cate_18 insu_cate_28 insu_cate_38 insu_cate_48 insu_cate_58 insu_cate_68 year,/*
*/ylab(0(500)2000,angle(horizontal))  ytick(0(100)2000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("冷凍、空調及管道工程業_投保類型")subtitle("單位:間", position(1)size(3))
graph export "insucate8.png", replace

twoway connected insu_cate_19 insu_cate_29 insu_cate_39 insu_cate_49 insu_cate_59 insu_cate_69 year,/*
*/ylab(0(500)2000,angle(horizontal))  ytick(0(100)2000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("其他建築設備安裝業_投保類型")subtitle("單位:間", position(1)size(3))
graph export "insucate9.png", replace

twoway connected insu_cate_110 insu_cate_210 insu_cate_310 insu_cate_410 insu_cate_510 insu_cate_610 year,/*
*/ylab(0(500)2000,angle(horizontal))  ytick(0(100)2000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("建物完工裝修工程業_投保類型")subtitle("單位:間", position(1)size(3))
graph export "insucate10.png", replace

twoway connected insu_cate_111 insu_cate_211 insu_cate_311 insu_cate_411 insu_cate_511 insu_cate_611 year,/*
*/ylab(0(500)2000,angle(horizontal))  ytick(0(100)2000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("其他專門營造業_投保類型")subtitle("單位:間", position(1)size(3))
graph export "insucate11.png", replace

twoway connected insu_cate_112 insu_cate_212 insu_cate_312 insu_cate_412 insu_cate_512 insu_cate_612 year,/*
*/ylab(0(500)2000,angle(horizontal))  ytick(0(100)2000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("建築服務業_投保類型")subtitle("單位:間", position(1)size(3))
graph export "insucate12.png", replace

twoway connected insu_cate_113 insu_cate_213 insu_cate_313 insu_cate_413 insu_cate_513 insu_cate_613 year,/*
*/ylab(0(500)2000,angle(horizontal))  ytick(0(100)2000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("工程服務及相關技術顧問業_投保類型")subtitle("單位:間", position(1)size(3))
graph export "insucate13.png", replace

twoway connected insu_cate_114 insu_cate_214 insu_cate_314 insu_cate_414 insu_cate_514 insu_cate_614 year,/*
*/ylab(0(500)2000,angle(horizontal))  ytick(0(100)2000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("營造用機械設備租賃業_投保類型")subtitle("單位:間", position(1)size(3))
graph export "insucate14.png", replace

*********************************************
//單位全檔
use "D:\研究助理工作\營造業\0908攜出\unlb_insu_cate.dta", clear
sort year
forvalues i = 1/10{
by year: egen total_cate`i'=sum(insu_cate_`i')
format total_cate`i' %12.0gc

}
label var total_cate1  產業勞工及交通公用事業之員工
label var total_cate2  職業工會
label var total_cate3  政府機關及公私立學校之員工
label var total_cate4  公司、行號之員工
label var total_cate5  自願投保者
label var total_cate6  自營作業者
label var total_cate7  新聞、文化、公益及合作事業之員工
label var total_cate8  僅參加就業保險產業勞工及交通公用事業
label var total_cate9  94
label var total_cate10 僅參加就業保險公司、行號之員工

preserve
by year: keep if _n==1
export excel using "D:\研究助理工作\營造業\unlb_投保類型.xlsx", firstrow(varlabels) replace
restore

preserve
twoway connected total_cate1 total_cate4   year,/*
*/ylab(60000(10000)90000,angle(horizontal))  ytick(60000(5000)90000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("年份",width(30) height(6)size(3)) /*
*/title("投保類型")subtitle("單位:家", position(1)size(3))
graph export "unlb_insucate.png", replace

twoway connected total_cate5 year,/*
*/ylab(5000(200)6000,angle(horizontal))  ytick(5000(100)6000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("年份",width(30) height(6)size(3)) /*
*/title("投保類型")subtitle("單位:家", position(1)size(3))
graph export "unlb_insucate2.png", replace

twoway connected total_cate2 total_cate3 total_cate6 total_cate7 total_cate8 total_cate9 total_cate10 year,/*
*/ylab(0(200)800,angle(horizontal))  ytick(0(100)800) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("年份",width(30) height(6)size(3)) /*
*/title("投保類型")subtitle("單位:家", position(1)size(3))
graph export "unlb_insucate3.png", replace

restore


forvalue i = 1/10{
separate insu_cate_`i', by (ind_small)
}
forvalue j = 1/14{
label var insu_cate_1`j'  產業勞工及交通公用事業之員工
label var insu_cate_2`j'  職業工會
label var insu_cate_3`j'  政府機關及公私立學校之員工
label var insu_cate_4`j'  公司、行號之員工
label var insu_cate_5`j'  自願投保者
label var insu_cate_6`j'  自營作業者
label var insu_cate_7`j'  新聞、文化、公益及合作事業之員工
label var insu_cate_8`j'  僅參加就業保險產業勞工及交通公用事業
label var insu_cate_9`j'  94
label var insu_cate_10`j'  僅參加就業保險公司、行號之員工
}

twoway line insu_cate_11 insu_cate_21 insu_cate_31 insu_cate_41 insu_cate_51 insu_cate_61 year,/*
*/ylab(0(5000)20000,angle(horizontal))  ytick(0(1000)20000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("建築工程業_投保類型")subtitle("單位:間", position(1)size(3))
graph export "unlb_insucate1.png", replace

twoway line insu_cate_12 insu_cate_22 insu_cate_32 insu_cate_42 insu_cate_52 insu_cate_62 year,/*
*/ylab(0(500)2000,angle(horizontal))  ytick(0(100)2000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("道路工程業_投保類型")subtitle("單位:間", position(1)size(3))
graph export "unlb_insucate2.png", replace

twoway line insu_cate_13 insu_cate_23 insu_cate_33 insu_cate_43 insu_cate_53 insu_cate_63 year,/*
*/ylab(0(500)2000,angle(horizontal))  ytick(0(100)2000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("公用事業設施工程業_投保類型")subtitle("單位:間", position(1)size(3))
graph export "unlb_insucate3.png", replace

twoway line insu_cate_14 insu_cate_24 insu_cate_34 insu_cate_44 insu_cate_54 insu_cate_64 year,/*
*/ylab(0(10000)30000,angle(horizontal))  ytick(0(5000)30000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("其他土木工程業_投保類型")subtitle("單位:間", position(1)size(3))
graph export "unlb_insucate4.png", replace

twoway line insu_cate_15 insu_cate_25 insu_cate_35 insu_cate_45 insu_cate_55 insu_cate_65 year,/*
*/ylab(0(500)2000,angle(horizontal))  ytick(0(100)2000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("整地、基礎及結構工程業_投保類型")subtitle("單位:間", position(1)size(3))
graph export "unlb_insucate5.png", replace

twoway line insu_cate_16 insu_cate_26 insu_cate_36 insu_cate_46 insu_cate_56 insu_cate_66 year,/*
*/ylab(0(500)2000,angle(horizontal))  ytick(0(100)2000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("庭園景觀工程業_投保類型")subtitle("單位:間", position(1)size(3))
graph export "unlb_insucate6.png", replace

twoway line insu_cate_17 insu_cate_27 insu_cate_37 insu_cate_47 insu_cate_57 insu_cate_67 year,/*
*/ylab(0(5000)20000,angle(horizontal))  ytick(0(1000)21000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("機電、電信及電路設備安裝業_投保類型")subtitle("單位:間", position(1)size(3))
graph export "unlb_insucate7.png", replace

twoway line insu_cate_18 insu_cate_28 insu_cate_38 insu_cate_48 insu_cate_58 insu_cate_68 year,/*
*/ylab(0(5000)20000,angle(horizontal))  ytick(0(1000)20000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("冷凍、空調及管道工程業_投保類型")subtitle("單位:間", position(1)size(3))
graph export "unlb_insucate8.png", replace

twoway line insu_cate_19 insu_cate_29 insu_cate_39 insu_cate_49 insu_cate_59 insu_cate_69 year,/*
*/ylab(0(500)2000,angle(horizontal))  ytick(0(100)2000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("其他建築設備安裝業_投保類型")subtitle("單位:間", position(1)size(3))
graph export "unlb_insucate9.png", replace

twoway line insu_cate_110 insu_cate_210 insu_cate_310 insu_cate_410 insu_cate_510 insu_cate_610 year,/*
*/ylab(0(5000)20000,angle(horizontal))  ytick(0(1000)21000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("建物完工裝修工程業_投保類型")subtitle("單位:間", position(1)size(3))
graph export "unlb_insucate10.png", replace

twoway line insu_cate_111 insu_cate_211 insu_cate_311 insu_cate_411 insu_cate_511 insu_cate_611 year,/*
*/ylab(0(5000)20000,angle(horizontal))  ytick(0(1000)20000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("其他專門營造業_投保類型")subtitle("單位:間", position(1)size(3))
graph export "unlb_insucate11.png", replace

twoway line insu_cate_112 insu_cate_212 insu_cate_312 insu_cate_412 insu_cate_512 insu_cate_612 year,/*
*/ylab(0(500)2000,angle(horizontal))  ytick(0(100)2000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("建築服務業_投保類型")subtitle("單位:間", position(1)size(3))
graph export "unlb_insucate12.png", replace

twoway line insu_cate_113 insu_cate_213 insu_cate_313 insu_cate_413 insu_cate_513 insu_cate_613 year,/*
*/ylab(0(2000)8000,angle(horizontal))  ytick(0(1000)8000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("工程服務及相關技術顧問業_投保類型")subtitle("單位:間", position(1)size(3))
graph export "unlb_insucate13.png", replace

twoway line insu_cate_114 insu_cate_214 insu_cate_314 insu_cate_414 insu_cate_514 insu_cate_614 year,/*
*/ylab(0(500)2000,angle(horizontal))  ytick(0(100)2000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("投保單位數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("營造用機械設備租賃業_投保類型")subtitle("單位:間", position(1)size(3))
graph export "unlb_insucate14.png", replace

*********************************************
//投保類型人數
use "D:\研究助理工作\營造業\1030攜出\emp_cate.dta",clear
*keep if cate=="10"
replace foreign=. if part==1
sort times part
by times part: egen foreign_total=sum(foreign)
sort times cate part
by times cate part: egen foreign_cate=sum(foreign)
sort times part
by times part: egen n_total=sum(n)
sort times cate part
by times cate part: egen n_total_cate=sum(n)
drop if male==99
foreach i in foreign_total foreign_cate n_total_cate{
format `i' %12.0gc
}
foreach i in n_total_cate foreign_cate{
separate `i', by (cate)

label var `i'1  產業勞工及交通公用事業之員工
label var `i'2  職業工會
label var `i'3  政府機關及公私立學校之員工
label var `i'4  公司、行號之員工
label var `i'5  自願投保者
label var `i'6  新聞、文化、公益及合作事業之員工
}

foreach i in n n_total{
format `i' %12.0gc
separate `i', by (part)

}
foreach i in n0 n1 foreign{
format `i' %12.0gc
separate `i',by (male)
}
label var n00 "女性全職人數"
label var n01 "男性全職人數"

label var n10 "女性兼職人數"
label var n11 "男性兼職人數"

label var foreign_total "移工全職人數"

twoway line n_total0 times,/*
*/ylab(200000(50000)300000,angle(horizontal))  ytick(200000(25000)300000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("產業勞工及交通公用事業之員工_全職人數")subtitle("單位:人", position(1)size(3))
graph export "femp_cate10.png", replace

twoway line n00 n01 times,/*
*/ylab(50000(50000)200000,angle(horizontal))  ytick(50000(25000)200000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("產業勞工及交通公用事業之員工_全職人數")subtitle("單位:人", position(1)size(3))
graph export "femp_sex_cate10.png", replace

twoway line n_total1 times,/*
*/ylab(5000(5000)20000,angle(horizontal))  ytick(5000(2500)20000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("產業勞工及交通公用事業之員工_兼職人數")subtitle("單位:人", position(1)size(3))
graph export "pemp_cate10.png", replace


twoway line n10 n11 times,/*
*/ylab(0(5000)15000,angle(horizontal))  ytick(0(1000)15000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("產業勞工及交通公用事業之員工_兼職人數")subtitle("單位:人", position(1)size(3))
graph export "pemp_sex_cate10.png", replace


twoway line foreign_total times if foreign_total>0,/*
*/ylab(5000(5000)20000,angle(horizontal))  ytick(5000(1000)20000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("產業勞工及交通公用事業之員工_全職移工人數")subtitle("單位:人", position(1)size(3))
graph export "femp_for_cate10.png", replace

g foreign_=foreign_total/n_total
separate foreign_, by(part)
label var foreign_0 全職移工占比
label var foreign_1 兼職移工占比

twoway line foreign_0 times,/*
*/ylab(0(0.01)0.06,angle(horizontal))  ytick(0(0.005)0.06) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("比例") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("產業勞工及交通公用事業之員工_移工占比")
graph export "femp_fpercent_cate10.png", replace

preserve
drop if part==1
by times cate: keep if _n==_N
sort times
by times: egen cate3=sum(foreign_cate3)
by times: egen cate6=sum(foreign_cate6)
by times: gen foreign_cate99=cate3+cate6
label var foreign_cate99 其他

twoway line foreign_cate1 foreign_cate2 foreign_cate4 foreign_cate5 foreign_cate99 times,/*
*/ylab(0(5000)20000,angle(horizontal))  ytick(0(1000)20000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("移工人數_投保類型")subtitle("單位:人", position(1)size(3))
graph export "femp_for_cate.png", replace

set obs 609
replace cate = "99" if _n>=523
replace part = 0 if _n>=523
sort cate times
replace times=times[_n-522] if _n>=523
replace n_total_cate=n_total_cate[_n-87]+n_total_cate[_n-348] if _n>=523
replace foreign_cate=foreign_cate[_n-87]+foreign_cate[_n-348] if _n>=523
keep times cate n_total_cate foreign_cate
ren (times cate n_total_cate foreign_cate) (時間 投保類型 就業人數 移工人數)
order 投保類型 時間 就業人數 移工人數
drop if 投保類型=="40"|投保類型=="80"
label define 投保類型 10 "產業勞工及交通公用事業之員工" 20 "職業工會" 50 "公司、行號之員工" 70 "自願投保者" 99 "其他"
destring 投保類型,replace
label value 投保類型 投保類型
export excel using D:\研究助理工作\營造業\投保類型全職人數.xlsx ,firstrow(var) replace
restore

preserve
drop if part==1
by times cate: keep if _n==_N
sort times
by times: egen cate3=sum(n_total_cate3)
by times: egen cate6=sum(n_total_cate6)
by times: gen n_total_cate_99=cate3+cate6
label var n_total_cate_99 其他

twoway line n_total_cate1 n_total_cate2 n_total_cate4 n_total_cate5 n_total_cate_99 times,/*
*/ylab(0(100000)400000,angle(horizontal))  ytick(0(50000)400000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("全職人數_投保類型")subtitle("單位:人", position(1)size(3))
graph export "femp_cate.png", replace
restore

preserve
drop if part==0
by times cate: keep if _n==_N
sort times
by times: egen cate3=sum(n_total_cate3)
by times: egen cate6=sum(n_total_cate6)
by times: gen n_total_cate_99=cate3+cate6
label var n_total_cate_99 其他
twoway line n_total_cate1 n_total_cate2 n_total_cate4 n_total_cate5 n_total_cate_99 times,/*
*/ylab(0(10000)20000,angle(horizontal))  ytick(0(5000)20000) /*
*/xlab(2016(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("兼職人數_投保類型")subtitle("單位:人", position(1)size(3))
graph export "pemp_cate.png", replace

set obs 554
replace cate = "99" if _n>=468
replace part = 1 if _n>=468
sort cate times
replace times=times[_n-467] if _n>=468
replace n_total_cate=n_total_cate_99[_n-467] if _n>=468
keep times cate n_total_cate
ren (times cate n_total_cate) (時間 投保類型 就業人數)
order 投保類型 時間 就業人數
drop if 投保類型=="40"|投保類型=="80"
label define 投保類型 10 "產業勞工及交通公用事業之員工" 20 "職業工會" 50 "公司、行號之員工" 70 "自願投保者" 99 "其他"
destring 投保類型,replace
label value 投保類型 投保類型
export excel using D:\研究助理工作\營造業\投保類型兼職人數.xlsx ,firstrow(var) replace

restore


/*
label define tt 2010.25"t" 2011.25 "t+1" 2012.25 "t+2" 2013.25 "t+3" 2014.25 "t+4" 2015.25 "t+5" 2016.25 "t+6" 2017.25 "t+7" 2018.25 "t+8" 2019.25 "t+9" 2020.25 "t+10" 2021.25 "t+11" 2022.25 "t+12"
*/
cd "D:\研究助理工作\僑外生\分析"
use new_data\分析dep,clear
*drop if dep==.
sort times
by times :egen total_emp=sum(semp) //各年月就職人數


*gen pp=252045 //99畢業生人數

gen cjb_p=cjb/semp *100 //轉職人數比例
gen part_p=semp_p/semp *100 //兼職比例
gen emp_percent=semp/total_emp*100 //在職人數比例

foreach w in wage mwage_m_cpi mwage_i_cpi wage_r_cpi semp snemp cjb_p part_p{
seperate `w',by ( dep )
label var `w'1   011教育學門
label var `w'2   021藝術學門
label var `w'3   022人文學門
label var `w'4   023語文學門
label var `w'5   031社會及行為科學學門
label var `w'6   032新聞學及圖書資訊學門
label var `w'7   041商業及管理學門
label var `w'8   042法律學門
label var `w'9   051生命科學學門
label var `w'10  052環境學門
label var `w'11  053物理、化學及地球科學學門
label var `w'12  054數學及統計學門
label var `w'13  061資訊通訊科技學門
label var `w'14  071工程及工程業學門
label var `w'15  072製造及加工學門
label var `w'16  073建築及營建工程學門
label var `w'17  081農業學門
label var `w'18  082林業學門
label var `w'19  083漁業學門
label var `w'20  084獸醫學門
label var `w'21  091醫藥衛生學門
label var `w'22  092社會福利學門 
label var `w'23  101餐旅及民生服務學門
label var `w'24  102衛生及職業衛生服務學門
label var `w'25  103安全服務學門
*label var `w'26  104運輸服務學門
label var `w'27  999其他學門

}

*replace dep=111 if dep==.
foreach w in emp_percent{
seperate `w',by ( dep )
label var `w'1   011教育學門
label var `w'2   021藝術學門
label var `w'3   022人文學門
label var `w'4   023語文學門
label var `w'5   031社會及行為科學學門
label var `w'6   032新聞學及圖書資訊學門
label var `w'7   041商業及管理學門
label var `w'8   042法律學門
label var `w'9   051生命科學學門
label var `w'10  052環境學門
label var `w'11  053物理、化學及地球科學學門
label var `w'12  054數學及統計學門
label var `w'13  061資訊通訊科技學門
label var `w'14  071工程及工程業學門
label var `w'15  072製造及加工學門
label var `w'16  073建築及營建工程學門
label var `w'17  081農業學門
label var `w'18  082林業學門
label var `w'19  083漁業學門
label var `w'20  084獸醫學門
label var `w'21  091醫藥衛生學門
label var `w'22  092社會福利學門 
label var `w'23  101餐旅及民生服務學門
label var `w'24  102衛生及職業衛生服務學門
label var `w'25  103安全服務學門
*label var `w'26  104運輸服務學門
label var `w'27  999其他學門
*label var `w'111  104運輸服務學門

}





//就業人數//////////////////////////////////////////////////////////////////////


sort dep times
by dep:gen tt=_n
*keep if tt>=18

foreach i in semp snemp{
preserve
keep `i' tt dep
reshape wide `i',i(dep)j(tt)

export excel using \dep,firstrow(varlabel) sheet("`i'",replace) 
restore
	
}


twoway line semp7 semp13 semp14 semp23 times if times>=2012,/*
*/ylab(0(1000)8000,angle(horizontal))  ytick(0(1000)8000) /*
*/xlab(2012(2)2022)  xtick(2012(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("就業人數")subtitle("僑外生 單位:人", position(1)size(3))
graph export "graph\emp_dep1.png", replace

twoway line semp2 semp4 times if times>=2012,/*
*/ylab(0(300)1500,angle(horizontal))  ytick(0(300)1500) /*
*/xlab(2012(2)2022)  xtick(2012(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("就業人數")subtitle("僑外生 單位:人", position(1)size(3))
graph export "graph\emp_dep2.png", replace

twoway line semp1 semp3 semp5 semp6  semp9  semp11  semp15 semp16  semp21 times if times>=2012,/*
*/ylab(0(200)800,angle(horizontal))  ytick(0(200)800) /*
*/xlab(2012(2)2022)  xtick(2012(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("就業人數")subtitle("僑外生 單位:人", position(1)size(3))
graph export "graph\emp_dep3.png", replace

twoway line semp8 semp10 semp12 semp17 semp18 semp19 semp20  semp22 semp24 semp25 semp27 times if times>=2012,/*
*/ylab(0(100)300,angle(horizontal))  ytick(0(50)300) /*
*/xlab(2012(2)2022)  xtick(2012(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("就業人數")subtitle("僑外生 單位:人", position(1)size(3))
graph export "graph\emp_dep4.png", replace

/*
twoway line snemp7 snemp14 snemp13 times,/*
*/ylab(0(4000)16000,angle(horizontal))  ytick(0(4000)16500) /*
*/xlab(2008(2)2022)  xtick(2008(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("非就業人數")subtitle("僑外生 單位:人", position(1)size(3))
graph export "uemp.png", replace
*/


twoway line emp_percent7 emp_percent13 emp_percent14 emp_percent23 times if times>=2012 ,/*
*/ylab(0(10)50,angle(horizontal))  ytick(0(5)50) /*
*/xlab(2012(2)2022)  xtick(2012(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("在職比例") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("在職比例")subtitle("僑外生 單位:%", position(1)size(3))
graph export "graph\emp_bli1.png", replace

twoway line emp_percent1 emp_percent2 emp_percent3 emp_percent4  emp_percent5 emp_percent6 emp_percent8 emp_percent9 emp_percent10 emp_percent11 emp_percent12 emp_percent15 emp_percent16 emp_percent17 emp_percent18 emp_percent19 emp_percent20 emp_percent21 emp_percent22 emp_percent24 emp_percent25 emp_percent27 times if times>=2012 ,/*
*/ylab(0(2)10,angle(horizontal))  ytick(0(1)10) /*
*/xlab(2012(2)2022)  xtick(2012(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("在職比例") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("在職比例")subtitle("僑外生 單位:%", position(1)size(3))
graph export "graph\emp_bli2.png", replace
/*
twoway line emp_percent1 emp_percent3  emp_percent5 emp_percent6 emp_percent9 emp_percent11 emp_percent12 emp_percent15 emp_percent16 emp_percent21 times if times>=2012,/*
*/ylab(0(2)10,angle(horizontal))  ytick(0(1)10) /*
*/xlab(2012(2)2022)  xtick(2012(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("在職比例") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("在職比例")subtitle("僑外生 單位:%", position(1)size(3))
graph export "graph\emp_bli3.png", replace

twoway line emp_percent8 emp_percent10 emp_percent12 emp_percent17 emp_percent18 emp_percent19 emp_percent20  emp_percent22 emp_percent24 emp_percent25 emp_percent27 times if times>=2012,/*
*/ylab(0(2)10,angle(horizontal))  ytick(0(1)10) /*
*/xlab(2012(2)2022)  xtick(2012(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("在職比例") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("在職比例")subtitle("僑外生 單位:%", position(1)size(3))
graph export "graph\emp_bli4.png", replace
*/
/*
twoway line emp_percent4 emp_percent5 emp_percent6  times if times>2010.25 ,/*
*/ylab(0(10)30,angle(horizontal))  ytick(0(5)30) /*
*/xlab(2010(2)2022)  xtick(2010(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("在職比例")subtitle("僑外生 單位:%", position(1)size(3))
graph export "emp_3.png", replace

twoway line emp_percent8 emp_percent9 emp_percent10  times if times>2010.25 ,/*
*/ylab(0(10)30,angle(horizontal))  ytick(0(5)30) /*
*/xlab(2010(2)2022)  xtick(2010(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("在職比例")subtitle("僑外生 單位:%", position(1)size(3))
graph export "emp_4.png", replace

twoway line emp_percent11 emp_percent12 emp_percent13  times if times>2010.25 ,/*
*/ylab(0(10)30,angle(horizontal))  ytick(0(5)30) /*
*/xlab(2010(2)2022)  xtick(2010(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("在職比例")subtitle("僑外生 單位:%", position(1)size(3))
graph export "emp_5.png", replace

twoway line emp_percent15 emp_percent16 emp_percent17  times if times>2010.25 ,/*
*/ylab(0(10)30,angle(horizontal))  ytick(0(5)30) /*
*/xlab(2010(2)2022)  xtick(2010(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("在職比例")subtitle("僑外生 單位:%", position(1)size(3))
graph export "emp_6.png", replace

twoway line emp_percent18 emp_percent19 emp_percent20  times if times>2010.25 ,/*
*/ylab(0(10)30,angle(horizontal))  ytick(0(5)30) /*
*/xlab(2010(2)2022)  xtick(2010(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("在職比例")subtitle("僑外生 單位:%", position(1)size(3))
graph export "emp_7.png", replace

twoway line emp_percent22 emp_percent23 emp_percent24  times if times>2010.25 ,/*
*/ylab(0(10)30,angle(horizontal))  ytick(0(5)30) /*
*/xlab(2010(2)2022)  xtick(2010(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("在職比例")subtitle("僑外生 單位:%", position(1)size(3))
graph export "emp_8.png", replace

twoway line emp_percent25 emp_percent26  times if times>2010.25 ,/*
*/ylab(0(10)30,angle(horizontal))  ytick(0(5)30) /*
*/xlab(2010(2)2022)  xtick(2010(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("在職比例")subtitle("僑外生 單位:%", position(1)size(3))
graph export "emp_9.png", replace




//轉職//////////////////////////////////////////////////////////////////////////

local r=1
foreach i in  1 4 7 10 13 16 19 22  {

local o=`i'
local p=`i'+1
local q=`i'+2

twoway line cjb_p`o' cjb_p`p' cjb_p`q' times if times>2010.25 ,/*
*/ylab(0(20)100,angle(horizontal))  ytick(0(10)100) /*
*/xlab(2010(2)2022)  xtick(2010(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("轉職比例")subtitle("僑外生 單位:%", position(1)size(3))
graph export "cjb_`r'.png", replace
local r=`r'+1	
	
}
twoway line cjb_p25 cjb_p26  times if times>2010.25 ,/*
*/ylab(0(20)100,angle(horizontal))  ytick(0(10)100) /*
*/xlab(2010(2)2022)  xtick(2010(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("轉職比例")subtitle("僑外生 單位:%", position(1)size(3))
graph export "cjb_9.png", replace


//兼職比例//////////////////////////////////////////////////////////////////////

local r=1
foreach i in  1 4 7 10 13 16 19 22  {

local o=`i'
local p=`i'+1
local q=`i'+2

twoway line part_p`o' part_p`p' part_p`q' times if times>2010.25 ,/*
*/ylab(0(10)60,angle(horizontal))  ytick(0(5)60) /*
*/xlab(2010(2)2022)  xtick(2010(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("兼職比例")subtitle("僑外生 單位:%", position(1)size(3))
*graph export "graph\part`r'.png", replace
local r=`r'+1	
	
}
twoway line part_p7 part_p13  times if times>2010.25 ,/*
*/ylab(0(10)100,angle(horizontal))  ytick(0(5)100) /*
*/xlab(2010(2)2022)  xtick(2010(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("兼職比例")subtitle("僑外生 單位:%", position(1)size(3))
graph export "part_9.png", replace





//勞退平均薪資//////////////////////////////////////////////////////////////////

twoway line mwage_r1 mwage_r2 mwage_r3 times if times>2010.25 ,/*
*/ylab(20000(10000)60000,angle(horizontal))  ytick(20000(2000)60000) /*
*/xlab(2010(2)2022)  xtick(2010(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("平均勞退薪資")subtitle("僑外生", position(1)size(3))
graph export "dep_r_1.png", replace


twoway line mwage_r4 mwage_r5 mwage_r6 times if times>2010.25 ,/*
*/ylab(20000(10000)60000,angle(horizontal))  ytick(20000(2000)60000) /*
*/xlab(2010(2)2022)  xtick(2010(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("平均勞退薪資")subtitle("僑外生", position(1)size(3))
graph export "dep_r_2.png", replace


twoway line mwage_r7 mwage_r8 mwage_r9 times if times>2010.25 ,/*
*/ylab(20000(10000)60000,angle(horizontal))  ytick(20000(2000)60000) /*
*/xlab(2010(2)2022)  xtick(2010(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("平均勞退薪資")subtitle("僑外生", position(1)size(3))
graph export "dep_r_3.png", replace


twoway line mwage_r10 mwage_r11 mwage_r12 times if times>2010.25 ,/*
*/ylab(20000(10000)60000,angle(horizontal))  ytick(20000(2000)60000) /*
*/xlab(2010(2)2022)  xtick(2010(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("平均勞退薪資")subtitle("僑外生", position(1)size(3))
graph export "dep_r_4.png", replace


twoway line mwage_r13 mwage_r14 mwage_r15 times if times>2010.25 ,/*
*/ylab(20000(10000)60000,angle(horizontal))  ytick(20000(2000)60000) /*
*/xlab(2010(2)2022)  xtick(2010(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("平均勞退薪資")subtitle("僑外生", position(1)size(3))
graph export "dep_r_5.png", replace

twoway line mwage_r16 mwage_r17 mwage_r18 times if times>2010.25 ,/*
*/ylab(20000(10000)60000,angle(horizontal))  ytick(20000(2000)60000) /*
*/xlab(2010(2)2022)  xtick(2010(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("平均勞退薪資")subtitle("僑外生", position(1)size(3))

graph export "dep_r_6.png", replace

twoway line mwage_r19 mwage_r20 mwage_r21 times if times>2010.25 ,/*
*/ylab(20000(10000)60000,angle(horizontal))  ytick(20000(2000)60000) /*
*/xlab(2010(2)2022)  xtick(2010(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("平均勞退薪資")subtitle("僑外生", position(1)size(3))
graph export "dep_r_7.png", replace

twoway line mwage_r22 mwage_r23 mwage_r24 times if times>2010.25 ,/*
*/ylab(20000(10000)60000,angle(horizontal))  ytick(20000(2000)60000) /*
*/xlab(2010(2)2022)  xtick(2010(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("平均勞退薪資")subtitle("僑外生", position(1)size(3))
graph export "dep_r_8.png", replace

twoway line mwage_r25 mwage_r26  times if times>2010.25 ,/*
*/ylab(20000(10000)60000,angle(horizontal))  ytick(20000(2000)60000) /*
*/xlab(2010(2)2022)  xtick(2010(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("平均勞退薪資")subtitle("僑外生", position(1)size(3))
graph export "dep_r_9.png", replace
	
*/
 if times>=2012 
 
//勞保平均薪資

twoway line mwage_i_cpi1 mwage_i_cpi2 mwage_i_cpi3 times,/*
*/ylab(10000(10000)50000,angle(horizontal))  ytick(10000(2500)50000) /*
*/xlab(2008(2)2022)  xtick(2008(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("勞保薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_學門勞保薪資")subtitle("單位:元", position(1)size(3))
graph export "graph\2dep_i_1.png", replace


twoway line mwage_i_cpi4 mwage_i_cpi5 mwage_i_cpi6 times,/*
*/ylab(10000(10000)50000,angle(horizontal))  ytick(10000(2500)50000) /*
*/xlab(2008(2)2022)  xtick(2008(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("勞保薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_學門勞保薪資")subtitle("單位:元", position(1)size(3))
graph export "graph\2dep_i_2.png", replace


twoway line mwage_i_cpi7 mwage_i_cpi8 mwage_i_cpi9 times,/*
*/ylab(10000(10000)50000,angle(horizontal))  ytick(10000(2500)50000) /*
*/xlab(2008(2)2022)  xtick(2008(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("勞保薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_學門勞保薪資")subtitle("單位:元", position(1)size(3))
graph export "graph\2dep_i_3.png", replace

twoway line mwage_i_cpi10 mwage_i_cpi11 mwage_i_cpi12 times,/*
*/ylab(10000(10000)50000,angle(horizontal))  ytick(10000(2500)50000) /*
*/xlab(2008(2)2022)  xtick(2008(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("勞保薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_學門勞保薪資")subtitle("單位:元", position(1)size(3))
graph export "graph\2dep_i_4.png", replace

twoway line mwage_i_cpi13 mwage_i_cpi14 mwage_i_cpi15 times,/*
*/ylab(10000(10000)50000,angle(horizontal))  ytick(10000(2500)50000) /*
*/xlab(2008(2)2022)  xtick(2008(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("勞保薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_學門勞保薪資")subtitle("單位:元", position(1)size(3))
graph export "graph\2dep_i_5.png", replace

twoway line mwage_i_cpi16 mwage_i_cpi17 mwage_i_cpi18 times,/*
*/ylab(10000(10000)50000,angle(horizontal))  ytick(10000(2500)50000) /*
*/xlab(2008(2)2022)  xtick(2008(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("勞保薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_學門勞保薪資")subtitle("單位:元", position(1)size(3))
graph export "graph\2dep_i_6.png", replace

twoway line mwage_i_cpi19 mwage_i_cpi20 mwage_i_cpi21 times,/*
*/ylab(10000(10000)50000,angle(horizontal))  ytick(10000(2500)50000) /*
*/xlab(2008(2)2022)  xtick(2008(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("勞保薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_學門勞保薪資")subtitle("單位:元", position(1)size(3))
graph export "graph\2dep_i_7.png", replace

twoway line mwage_i_cpi22 mwage_i_cpi23 mwage_i_cpi24 times,/*
*/ylab(10000(10000)50000,angle(horizontal))  ytick(10000(2500)50000) /*
*/xlab(2008(2)2022)  xtick(2008(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("勞保薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_學門勞保薪資")subtitle("單位:元", position(1)size(3))
graph export "graph\2dep_i_8.png", replace

twoway line mwage_i_cpi25 mwage_i_cpi27 times,/*
*/ylab(10000(10000)50000,angle(horizontal))  ytick(10000(2500)50000) /*
*/xlab(2008(2)2022)  xtick(2008(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("勞保薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_學門勞保薪資")subtitle("單位:元", position(1)size(3))
graph export "graph\2dep_i_9.png", replace

***********************************************************************

twoway line mwage_m_cpi1 mwage_m_cpi2 mwage_m_cpi3 times if times>=2012,/*
*/ylab(20000(10000)50000,angle(horizontal))  ytick(20000(2500)52500) /*
*/xlab(2012(2)2022)  xtick(2012(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("月薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_學門月薪資")subtitle("單位:元", position(1)size(3))
graph export "graph\2dep_m_1.png", replace

 
twoway line mwage_m_cpi4 mwage_m_cpi5 mwage_m_cpi6 times if times>=2012,/*
*/ylab(20000(10000)50000,angle(horizontal))  ytick(20000(2500)50000) /*
*/xlab(2012(2)2022)  xtick(2012(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("月薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_學門月薪資")subtitle("單位:元", position(1)size(3))
graph export "graph\2dep_m_2.png", replace

twoway line mwage_m_cpi7 mwage_m_cpi8 mwage_m_cpi9 times if times>=2012,/*
*/ylab(20000(10000)50000,angle(horizontal))  ytick(20000(2500)52500) /*
*/xlab(2012(2)2022)  xtick(2012(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("月薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_學門月薪資")subtitle("單位:元", position(1)size(3))
graph export "graph\2dep_m_3.png", replace

twoway line mwage_m_cpi10 mwage_m_cpi11 mwage_m_cpi12 times if times>=2012,/*
*/ylab(20000(10000)50000,angle(horizontal))  ytick(20000(2500)50000) /*
*/xlab(2012(2)2022)  xtick(2012(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("月薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_學門月薪資")subtitle("單位:元", position(1)size(3))
graph export "graph\2dep_m_4.png", replace

twoway line mwage_m_cpi13 mwage_m_cpi14 mwage_m_cpi15 times if times>=2012,/*
*/ylab(20000(10000)50000,angle(horizontal))  ytick(20000(2500)50000) /*
*/xlab(2012(2)2022)  xtick(2012(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("月薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_學門月薪資")subtitle("單位:元", position(1)size(3))
graph export "graph\2dep_m_5.png", replace

twoway line mwage_m_cpi16 mwage_m_cpi17 mwage_m_cpi18 times if times>=2012,/*
*/ylab(20000(10000)50000,angle(horizontal))  ytick(20000(2500)50000) /*
*/xlab(2012(2)2022)  xtick(2012(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("月薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_學門月薪資")subtitle("單位:元", position(1)size(3))
graph export "graph\2dep_m_6.png", replace

twoway line mwage_m_cpi19 mwage_m_cpi20 mwage_m_cpi25 mwage_m_cpi27 times if times>=2012,/*
*/ylab(20000(10000)50000,angle(horizontal))  ytick(20000(2500)52500) /*
*/xlab(2012(2)2022)  xtick(2012(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("月薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_學門月薪資")subtitle("單位:元", position(1)size(3))
graph export "graph\2dep_m_7.png", replace

twoway line mwage_m_cpi22 mwage_m_cpi23 mwage_m_cpi24 times if times>=2012,/*
*/ylab(20000(10000)50000,angle(horizontal))  ytick(20000(2500)50000) /*
*/xlab(2012(2)2022)  xtick(2012(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("月薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_學門月薪資")subtitle("單位:元", position(1)size(3))
graph export "graph\2dep_m_8.png", replace

twoway line  mwage_m_cpi21 times if times>=2012,/*
*/ylab(20000(10000)80000,angle(horizontal))  ytick(20000(5000)80000) /*
*/xlab(2012(2)2022)  xtick(2012(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("月薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_091醫藥衛生學門月薪資")subtitle("單位:元", position(1)size(3))
graph export "graph\2dep_m_9.png", replace



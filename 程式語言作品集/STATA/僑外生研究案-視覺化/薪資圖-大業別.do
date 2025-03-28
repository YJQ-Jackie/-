cd "D:\研究助理工作\僑外生\分析"
use new_data\fcol_pind1,clear

foreach w in wage_i_mcpi wage_m_mcpi{
seperate `w',by ( ind1 )
label var `w'1   不動產業
label var `w'2   住宿及餐飲業
label var `w'3   公共行政及國防；強制性社會安全
label var `w'4   其他服務業
label var `w'5   出版影音及資通訊業
label var `w'6   專業、科學及技術服務業
label var `w'7   批發及零售業
label var `w'8   支援服務業
label var `w'9   教育業
label var `w'10  營建工程業
label var `w'11  用水供應及污染整治業
label var `w'12  礦業及土石採取業
label var `w'13  藝術、娛樂及休閒服務業
label var `w'14  製造業
label var `w'15  農、林、漁、牧業
label var `w'16  運輸及倉儲業
label var `w'17  醫療保健及社會工作服務業
label var `w'18  金融及保險業
label var `w'19  電力及燃氣供應業
	
}


/*
twoway line mwage_i_cpi1 mwage_i_cpi2 mwage_i_cpi3 mwage_i_cpi4 mwage_i_cpi5 times,/*
*/ylab(20000(20000)60000,angle(horizontal))  ytick(20000(10000)60000) /*
*/xlab(2008(2)2022)  xtick(2008(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("勞保薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_勞保薪資")subtitle("單位:元", position(1)size(3))
graph export "graph\ind1_wi1.png", replace

twoway line mwage_i_cpi6 mwage_i_cpi7 mwage_i_cpi8 mwage_i_cpi9 mwage_i_cpi10 times,/*
*/ylab(20000(20000)60000,angle(horizontal))  ytick(20000(10000)35000) /*
*/xlab(2008(2)2022)  xtick(2008(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("勞保薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_勞保薪資")subtitle("單位:元", position(1)size(3))
graph export "graph\ind1_wi2.png", replace

twoway line mwage_i_cpi11 mwage_i_cpi12 mwage_i_cpi13 mwage_i_cpi14 mwage_i_cpi15 times,/*
*/ylab(20000(20000)60000,angle(horizontal))  ytick(20000(10000)35000) /*
*/xlab(2008(2)2022)  xtick(2008(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("勞保薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_勞保薪資")subtitle("單位:元", position(1)size(3))
graph export "graph\ind1_wi3.png", replace
*/

//勞保薪資
local r=1
foreach i in  1 4 7 10 13 {

local o=`i'
local p=`i'+1
local q=`i'+2

twoway line wage_i_mcpi`o' wage_i_mcpi`p' wage_i_mcpi`q' times if part==0,/*
*/ylab(10000(20000)50000,angle(horizontal))  ytick(10000(10000)50000) /*
*/xlab(2012(2)2022)  xtick(2012(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("勞保薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_各業別勞保薪資")subtitle("單位:元", position(1)size(3))
graph export "new_graph\ind1_wi`r'.png", replace
local r=`r'+1	

}
twoway line wage_i_mcpi16 wage_i_mcpi17 wage_i_mcpi18 wage_i_mcpi19 times if part==0,/*
*/ylab(10000(20000)50000,angle(horizontal))  ytick(10000(10000)50000) /*
*/xlab(2012(2)2022)  xtick(2012(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("勞保薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_各業別勞保薪資")subtitle("單位:元", position(1)size(3))
graph export "new_graph\ind1_wi7.png", replace

//月薪資
twoway line wage_m_mcpi1 wage_m_mcpi2 wage_m_mcpi3 wage_m_mcpi4 times if times>=2012&part==0,/*
*/ylab(20000(20000)60000,angle(horizontal))  ytick(20000(10000)60000) /*
*/xlab(2012(2)2022)  xtick(2012(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("月薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_各業別月薪資")subtitle("單位:元", position(1)size(3))
graph export "new_graph\ind1_wm1.png", replace

twoway line wage_m_mcpi5 wage_m_mcpi6 wage_m_mcpi7 wage_m_mcpi10 times if times>=2012&part==0,/*
*/ylab(20000(20000)100000,angle(horizontal))  ytick(20000(10000)100000) /*
*/xlab(2012(2)2022)  xtick(2012(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("月薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_各業別月薪資")subtitle("單位:元", position(1)size(3))
graph export "new_graph\ind1_wm2.png", replace

twoway line wage_m_mcpi8 wage_m_mcpi9 wage_m_mcpi14 times if times>=2012&part==0,/*
*/ylab(20000(20000)60000,angle(horizontal))  ytick(20000(10000)60000) /*
*/xlab(2012(2)2022)  xtick(2012(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("月薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_各業別月薪資")subtitle("單位:元", position(1)size(3))
graph export "new_graph\ind1_wm3.png", replace

twoway line wage_m_mcpi11 wage_m_mcpi12 wage_m_mcpi13 wage_m_mcpi15 times if times>=2012&part==0,/*
*/ylab(20000(20000)60000,angle(horizontal))  ytick(20000(10000)60000) /*
*/xlab(2012(2)2022)  xtick(2012(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("月薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_各業別月薪資")subtitle("單位:元", position(1)size(3))
graph export "new_graph\ind1_wm4.png", replace

twoway line wage_m_mcpi16 wage_m_mcpi17 wage_m_mcpi18 wage_m_mcpi19 times if times>=2012&part==0,/*
*/ylab(20000(20000)100000,angle(horizontal))  ytick(20000(10000)100000) /*
*/xlab(2012(2)2022)  xtick(2012(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("月薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_各業別月薪資")subtitle("單位:元", position(1)size(3))
graph export "new_graph\ind1_wm5.png", replace


//mwage_m_cpi6 mwage_m_cpi4 mwage_m_cpi14 mwage_m_cpi7 mwage_m_cpi10

/*
local r=1
foreach i in  1 4 7 10 13{

local o=`i'
local p=`i'+1
local q=`i'+2

twoway line wage_r_cpi`o' wage_r_cpi`p' wage_r_cpi`q' times,/*
*/ylab(20000(20000)60000,angle(horizontal))  ytick(20000(10000)60000) /*
*/xlab(2008(2)2022)  xtick(2008(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("勞退薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_各業別勞退薪資")subtitle("單位:元", position(1)size(3))
graph export "graph\ind1_wt`r'.png", replace
local r=`r'+1	

}
*/

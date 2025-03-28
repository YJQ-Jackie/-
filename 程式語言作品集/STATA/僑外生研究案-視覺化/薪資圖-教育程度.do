cd "D:\研究助理工作\僑外生\分析"
use new_data\fcol_pedu,clear

foreach w in wage_m_mcpi wage_i_mcpi {
separate `w',by ( 教育程度 )
label var `w'1   "高中(含以下)"
label var `w'2   "專科"
label var `w'3   "學士"
label var `w'4   "碩士"
label var `w'5   "博士"

}

twoway line wage_i_mcpi1 wage_i_mcpi2 wage_i_mcpi3 wage_i_mcpi4 wage_i_mcpi5  times if  times>=2012&part==0,/*
*/ylab(20000(10000)60000,angle(horizontal))  ytick(20000(10000)60000) /*
*/xlab(2008(2)2022)  xtick(2008(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("勞保薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_教育程度勞保薪資")subtitle("單位:元", position(1)size(3))
graph export "new_graph\edu_wi.png", replace

twoway line wage_m_mcpi1 wage_m_mcpi2 wage_m_mcpi3 wage_m_mcpi4 wage_m_mcpi5 times if times>=2012&part==0,/*
*/ylab(20000(10000)80000,angle(horizontal))  ytick(20000(10000)80000) /*
*/xlab(2012(2)2022)  xtick(2012(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("勞保薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_教育程度月薪資")subtitle("單位:元", position(1)size(3))
graph export "new_graph\edu_wm.png", replace

/*
twoway line mwage_m_cpi1 mwage_m_cpi2 mwage_m_cpi3 mwage_m_cpi4 mwage_m_cpi5 times if times>=2012,/*
*/ylab(20000(10000)60000,angle(horizontal))  ytick(20000(10000)60000) /*
*/xlab(2012(2)2022)  xtick(2012(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("勞保薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_教育程度月薪資")subtitle("單位:元", position(1)size(3))
graph export "graph\edu_wm.png", replace
*/

cd "D:\分析"
use new_data\fcol_pt,clear
/*
label var semp 就業人數
label var semp_p 兼職人數
*/
keep if part==0
ren wage_i_mcpi mwage_i_cpi
ren wage_m_mcpi mwage_m_cpi
twoway line mwage_i_cpi times,/*
*/ylab(20000(20000)60000,angle(horizontal))  ytick(20000(10000)60000) /*
*/xlab(2012(2)2022)  xtick(2012(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("勞保薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_勞保薪資")subtitle("單位:元", position(1)size(3))
graph export "new_graph\t_wi.png", replace

twoway line mwage_m_cpi times,/*
*/ylab(20000(20000)80000,angle(horizontal))  ytick(20000(10000)80000)/*
*/xlab(2012(2)2022)  xtick(2012(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("月薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_月薪資")subtitle("單位:元", position(1)size(3))
graph export "new_graph\t_wm.png", replace
/*
twoway line semp semp_p times,/*
*/ylab(0(5000)30000,angle(horizontal))  ytick(0(2500)30000)/*
*/xlab(2008(2)2022)  xtick(2008(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_就業人數")subtitle("單位:人", position(1)size(3))
graph export "graph\t_emp.png", replace

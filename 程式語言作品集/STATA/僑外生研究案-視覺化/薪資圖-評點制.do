cd "D:\研究助理工作\僑外生\分析"
use new_data\fcol_pd.dta ,clear
ren wage_i_mcpi wage_i_cpi
ren wage_m_mcpi wage_m_cpi
ren (wage10m wage25m wage50m wage75m wage90m) (wage10c wage25c wage50c wage75c wage90c)

foreach w in wage_i_cpi wage_m_cpi wage10c wage25c wage50c wage75c wage90c{
seperate `w',by (pd_num)
label var `w'0   非評點制專業人才僑外生
label var `w'1   評點制專業人才僑外生
	
}

twoway line wage_m_cpi0 wage_m_cpi1 times if times>=2012&part==0,/*
*/ylab(20000(10000)70000,angle(horizontal))  ytick(20000(5000)70000) /*
*/xlab(2012(2)2022)  xtick(2012(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("月薪資")/*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("專業人才僑外生_月薪資")subtitle("單位:元", position(1)size(3))
graph export "new_graph\pd_wm.png", replace

twoway line wage_i_cpi0 wage_i_cpi1 times if part==0,/*
*/ylab(20000(10000)70000,angle(horizontal))  ytick(20000(5000)70000) /*
*/xlab(2012(2)2022)  xtick(2012(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("專業人才僑外生_勞保薪資")subtitle("單位:元", position(1)size(3))
graph export "new_graph\pd_wi.png", replace

/*
twoway line wage90c times ,/*
*/ylab(20000(10000)70000,angle(horizontal))  ytick(20000(5000)70000) /*
*/xlab(2012(2)2022)  xtick(2012(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-)symb(o t) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("專業人才僑外生勞保薪資")subtitle("僑外生", position(1)size(3))
graph export "graph\pd_wi.png", replace
*/

use "D:\研究助理工作\僑外生\分析\new_data\survival.dta" ,clear
replace _t=round(_t,0.1)
sts graph, by( school_tpp ) xlabel(0(1)15) ytitle(留台機率) xtitle(留台時間(年)) title(留台時間_教育程度)

cd "D:\研究助理工作\僑外生\分析"
use new_data\fcol_coun,clear

foreach w in wage_i_mcpi wage_m_mcpi{
seperate `w',by ( country )
label var `w'3   汶萊
label var `w'4   緬甸
label var `w'5   柬埔寨
label var `w'6   斯里蘭卡
label var `w'7   印度
label var `w'8   印尼
label var `w'9   伊朗
label var `w'10   伊拉克
label var `w'11  以色列
label var `w'12  日本
label var `w'13  約旦
label var `w'14  韓國
label var `w'15  科威特
label var `w'17  黎巴嫩
label var `w'18  馬來西亞
label var `w'20  蒙古
label var `w'21  尼泊爾
label var `w'22  巴基斯坦
label var `w'23  菲律賓
label var `w'24  新加坡
label var `w'26  泰國
label var `w'27  土耳其
label var `w'28  越南
label var `w'30  香港
label var `w'35  孟加拉共和國
label var `w'36  吉里巴斯
label var `w'38  索羅門群島
label var `w'41  巴勒斯坦
label var `w'42  澳門
label var `w'46  澳大利亞
label var `w'48  諾魯
label var `w'49  紐西蘭
label var `w'52  奧地利
label var `w'53  比利時
label var `w'54  保加利亞
label var `w'56  捷克
label var `w'59  法國
label var `w'60  德國
label var `w'61  希臘
label var `w'63  匈牙利
label var `w'65 愛爾蘭
label var `w'66  義大利
label var `w'69  荷蘭
label var `w'71  波蘭
label var `w'72  葡萄牙
label var `w'74  西班牙
label var `w'75  瑞典
label var `w'76  瑞士
label var `w'77  烏克蘭
label var `w'78  英國
label var `w'80  巴布亞紐幾內亞
label var `w'83  亞美尼亞
label var `w'84  俄羅斯
label var `w'86  烏茲別克
label var `w'87  哈薩克
label var `w'88  吉爾吉斯
label var `w'89  塔吉克
label var `w'90  土庫曼
label var `w'91  亞塞拜然
label var `w'92  喬治亞
label var `w'93  克羅埃西亞
label var `w'94  斯洛凡尼亞
label var `w'97  斯洛伐克
label var `w'98  塞爾維亞
label var `w'102 加拿大
label var `w'103 哥斯大黎加
label var `w'104 多明尼加
label var `w'105 薩爾瓦多
label var `w'106  瓜地馬拉
label var `w'107  海地
label var `w'108  宏都拉斯
label var `w'110  墨西哥
label var `w'111  尼加拉瓜
label var `w'112  巴拿馬
label var `w'113  美國
label var `w'116  阿根廷
label var `w'117  玻利維亞
label var `w'118  巴西
label var `w'119  智利
label var `w'120  哥倫比亞
label var `w'121  厄瓜多
label var `w'122  巴拉圭
label var `w'123  秘魯
label var `w'129  波札那
label var `w'131  喀麥隆
label var `w'132  查德
label var `w'136  衣索匹亞
label var `w'137  加彭
label var `w'138  甘比亞
label var `w'142  肯亞
label var `w'145  馬拉威
label var `w'147  模里西斯
label var `w'148  摩洛哥
label var `w'149  奈及利亞
label var `w'150  辛巴威
label var `w'155  南非
label var `w'157  史瓦帝尼王國
label var `w'160  突尼西亞
label var `w'162  埃及
label var `w'163  布吉納法索
label var `w'166  莫三比克
label var `w'169  聖多美普林西比
label var `w'173  聖文森及格瑞那丁
label var `w'174  聖露西亞
label var `w'175  聖克里斯多福
label var `w'176  貝里斯

}
*菲律賓 23
*馬來西亞 越南 印尼 香港 澳門 緬甸 泰國 日本 印度 蒙古
*7 印度 18馬來西亞 42 23 30
*8 4 12 26 28
*7 18 42 23 30
*美國113 俄羅斯84
twoway line  wage_i_mcpi18 wage_i_mcpi7  wage_i_mcpi42 wage_i_mcpi20  wage_i_mcpi30 times if part==0&times>=2012,/*
*/ylab(10000(20000)50000,angle(horizontal))  ytick(10000(10000)50000) /*
*/xlab(2012(2)2023)  xtick(2012(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("勞保薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_國籍別勞保薪資")subtitle("單位:元", position(1)size(3))
graph export "new_graph\coun_wi1.png", replace

twoway line wage_i_mcpi26 wage_i_mcpi8 wage_i_mcpi4 wage_i_mcpi12 wage_i_mcpi28 times if part==0&times>=2012,/*
*/ylab(10000(20000)50000,angle(horizontal))  ytick(10000(10000)50000) /*
*/xlab(2012(2)2023)  xtick(2012(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("勞保薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_國籍別勞保薪資")subtitle("單位:元", position(1)size(3))
graph export "new_graph\coun_wi2.png", replace

twoway line wage_m_mcpi7 wage_m_mcpi18 wage_m_mcpi42 wage_m_mcpi20 wage_m_mcpi30 wage_m_mcpi84 times if part==0&times>=2012,/*
*/ylab(20000(10000)90000,angle(horizontal))  ytick(20000(5000)90000) /*
*/xlab(2012(2)2023)  xtick(2012(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("月薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_國籍別月薪資")subtitle("單位:元", position(1)size(3))
graph export "new_graph\coun_wm1.png", replace

twoway line wage_m_mcpi8 wage_m_mcpi4 wage_m_mcpi12 wage_m_mcpi26 wage_m_mcpi28 wage_m_mcpi113 times if part==0&times>=2012,/*
*/ylab(20000(10000)80000,angle(horizontal))  ytick(20000(5000)80000) /*
*/xlab(2012(2)2023)  xtick(2012(1)2023) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("月薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_國籍別月薪資")subtitle("單位:元", position(1)size(3))
graph export "new_graph\coun_wm2.png", replace
/**********************
twoway line semp27 semp17 semp7 times,/*
*/ylab(0(2000)10000,angle(horizontal))  ytick(0(1000)10000) /*
*/xlab(2008(2)2022)  xtick(2008(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_國籍別就業人數")subtitle("單位:元", position(1)size(3))
graph export "graph\coun_emp.png", replace

twoway line semp29 semp3 semp41 semp25 semp11 semp6 semp22 times,/*
*/ylab(0(500)800,angle(horizontal))  ytick(0(500)800) /*
*/xlab(2008(2)2022)  xtick(2012(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("就業人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_國籍別就業人數")subtitle("單位:元", position(1)size(3))


******************/
twoway line semp_f27 semp_f17 semp_f7 times,/*
*/ylab(0(2000)6000,angle(horizontal))  ytick(0(1000)6000) /*
*/xlab(2008(2)2022)  xtick(2008(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("全職人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_國籍別全職人數")subtitle("單位:人", position(1)size(3))
graph export "graph\coun_emp1.png", replace

twoway line semp_p29 semp_p41 semp_p3 semp_p25 semp_p11 semp_p6 semp_p22 times,/*
*/ylab(0(500)2000,angle(horizontal))  ytick(0(250)2000) /*
*/xlab(2008(2)2022)  xtick(2008(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("全職人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_國籍別全職人數")subtitle("單位:人", position(1)size(3))
graph export "graph\coun_emp2.png", replace

twoway line semp_p27 semp_p17 semp_p7 times,/*
*/ylab(0(2000)6000,angle(horizontal))  ytick(0(1000)6000) /*
*/xlab(2008(2)2022)  xtick(2008(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("兼職人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_國籍別兼職人數")subtitle("單位:人", position(1)size(3))
graph export "graph\coun_empp1.png", replace

twoway line semp_p29 semp_p41 semp_p3 semp_p25 semp_p11 semp_p6 semp_p22 times,/*
*/ylab(0(250)2000,angle(horizontal))  ytick(0(250)2000) /*
*/xlab(2008(2)2022)  xtick(2008(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("兼職人數") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_國籍別兼職人數")subtitle("單位:人", position(1)size(3))
graph export "graph\coun_empp2.png", replace

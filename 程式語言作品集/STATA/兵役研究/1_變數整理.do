
*主樣本
foreach i in 2004 2005 2007 2009 2011 2014 2016 2018 2020{
clear
cd "D:\家庭動態調查\主樣本\原始檔"
unicode analyze "rci`i'.dta"
unicode encoding set Big5
unicode translate "rci`i'.dta",invalid
use "D:\家庭動態調查\主樣本\原始檔\rci`i'.dta" ,clear

}
foreach i in 2000 2003 2009 2016{
clear
cd "D:\家庭動態調查\主樣本\原始檔"
unicode analyze "ri`i'.dta"
unicode encoding set Big5
unicode translate "ri`i'.dta",invalid
use "D:\家庭動態調查\主樣本\原始檔\ri`i'.dta" ,clear

}
*子女樣本
foreach i in 2000 2002 2004 2006 2008 2010 2012 2014 2016 2018 2020{
clear
cd "D:\家庭動態調查\子女樣本\data\"
unicode analyze "ci`i'.dta"
unicode encoding set Big5
unicode translate "ci`i'.dta",invalid
use "D:\家庭動態調查\子女樣本\data\ci`i'.dta" ,clear

}
*追蹤樣本
foreach i in 2000 2001_2 2001_3 2002 2003 2004 2005 2006 2007 2008 /*
*/2009 2010 2011 2012 2014 2016 2018 2020{
clear
cd "D:\家庭動態調查\主樣本追蹤\原始檔"
unicode analyze "RR`i'.dta"
unicode encoding set Big5
unicode translate "RR`i'.dta",invalid
use "D:\家庭動態調查\主樣本追蹤\原始檔\RR`i'.dta" ,clear

}

*number 前6碼為主樣本之樣本編號，第7碼為子女樣本之順序 
////////////////////////////////////////////////////////////////////////
*主樣本rci
clear

use "D:\家庭動態調查\主樣本\原始檔\rci2004.dta" ,clear
gen survey="rci"
gen survey_plan="rci2004"
rename x01 number //編號
rename x02 year //問卷年分
rename k08z01 month //訪問月份
rename x06 location //居住地
rename a01 sex //性別
rename a02 b_year //出生年
rename b01 edu //教育程度
rename b02z02 grad //是否畢肄業
rename b02z01 grad_y //畢肄業年分
rename b05 elem_year //國小開始年分
rename b08a jun_year //國中開始年分
rename b15a sen_year //高中開業年分
rename b24a coll_year //大學開始年分
rename b30a mast_year //碩士開始年分
rename c25a soldier //是否服過兵役 1有 2無
rename c25b01 sol_syear //入伍年
rename c25b02 sol_eyear //退伍年
rename c16 job1_year //第一份正職年分
rename c01 job_now //現在是否有工作 1有 2無
rename c07 job_whour //每週工時
rename c02 job_thisyear //今年是否有工作*
rename c10 job_lastyear //去年是否有工作*
rename c15z01 job_find //是否正在找工作
rename c15z02 f_month //找工作多少月
rename c15z03 f_week //找工作多少週
keep number year month location sex b_year /*
*/edu grad grad_y elem_year jun_year sen_year coll_year mast_year /*
*/job_now job_whour job_thisyear job_lastyear job_find f_month f_week job1_year /*
*/soldier sol_syear sol_eyear survey survey_plan 

*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4|edu==5 //4初(國)中、
replace eduy=12 if edu==6|edu==7|edu==8|edu==16 //6高中普通科、7高中職業科、8高職
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值

*畢業年 0跳答或不適用 98拒答
replace grad_y=9999 if grad_y==0|grad_y==98
*目前是否有工作 1有 2無->3無
replace job_now=3 if job_now==2
*第一次正式工作年 0跳答或不適用 99缺漏值
replace job1_year=9999 if job1_year==99
*現在工作每週工時
replace job_whour=9999 if job_whour==991|job_whour==996|job_whour==998
*找工作月數/週數 95超過95個月 96不知道 98拒答 99缺漏值
replace f_month=9999 if f_month==96|f_month==98|f_month==99
replace f_week=9999 if f_week==6|f_week==8|f_week==9 //6不知道 8拒答 9缺漏值
*入退伍年 0跳答或不適用 96不知道 99缺漏值
replace sol_syear=9999 if sol_syear==96|sol_syear==99
replace sol_eyear=9999 if sol_eyear==96|sol_eyear==99

save "D:\家庭動態調查\主樣本\data\psfd_rci2004.dta",replace

use "D:\家庭動態調查\主樣本\原始檔\rci2005.dta" ,clear
gen survey="rci"
gen survey_plan="rci2005"
rename x01 number
rename x02 year
rename x03z01 month 
rename x06 location
rename a01 sex
rename a02 b_year
rename b01 edu
rename b02z02 grad
rename b02z01 grad_y
rename b05 elem_year
rename b08a jun_year
rename b15a sen_year
rename b24a coll_year
rename b31a mast_year
rename c25a soldier
rename c25b01 sol_syear
rename c25b02 sol_eyear
rename c16 job1_year
rename c01 job_now
rename c07 job_whour //每週工時
rename c02 job_thisyear
rename c10 job_lastyear
rename c15z01 job_find
rename c15z02 f_month
rename c15z03 f_week
keep number year month location sex b_year /*
*/edu grad grad_y elem_year jun_year sen_year coll_year mast_year /*
*/job_now job_whour job_thisyear job_lastyear job_find f_month f_week job1_year /*
*/soldier sol_syear sol_eyear survey survey_plan 

*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4|edu==5 //4初(國)中、
replace eduy=12 if edu==6|edu==7|edu==8|edu==16 //6高中普通科、7高中職業科、8高職
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值

*畢業年 0跳答或不適用 98拒答
replace grad_y=9999 if grad_y==0|grad_y==98
*目前是否有工作 1有 2無->3無
replace job_now=3 if job_now==2
*第一次正式工作年 0跳答或不適用 99缺漏值
replace job1_year=9999 if job1_year==96
*找工作月數/週數 95超過95個月 96不知道 98拒答 99缺漏值
replace f_month=9999 if f_month==96|f_month==98|f_month==99
replace f_week=9999 if f_week==96 //96不知道 8拒答 9缺漏值
*入退伍年 0跳答或不適用 96不知道 99缺漏值
replace sol_syear=9999 if sol_syear==96|sol_syear==99
replace sol_eyear=9999 if sol_eyear==96|sol_eyear==99

save "D:\家庭動態調查\主樣本\data\psfd_rci2005.dta",replace

use "D:\家庭動態調查\主樣本\原始檔\rci2007.dta",clear
gen survey="rci"
gen survey_plan="rci2007"
rename x01 number
rename x02 year
rename x03z01 month 
rename x05 location
rename a01 sex
rename a02z01 b_year
rename a02z02 b_month
rename b01 edu
rename b02z01 grad
rename b02z02 grad_y
rename b05 elem_year
rename b08a jun_year
rename b15a sen_year
rename b24a coll_year
rename b31a mast_year
rename c25a soldier
rename c25c01 sol_syear
rename c25c02 sol_smonth
rename c25c03 sol_eyear
rename c25c04 sol_emonth
rename c16 job1_year
rename c01 job_now
rename c07 job_whour //每週工時
rename c02 job_thisyear
rename c10 job_lastyear
rename c15z01 job_find
rename c15z02 f_month
rename c15z03 f_week
keep number year month location sex b_year b_month /*
*/edu grad grad_y elem_year jun_year sen_year coll_year mast_year /*
*/job_now job_whour job_thisyear job_lastyear job_find f_month f_week job1_year /*
*/soldier sol_syear sol_smonth sol_eyear sol_emonth survey survey_plan 
*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4|edu==5 //4初(國)中
replace eduy=12 if edu==6|edu==7|edu==8|edu==16 //6高中普通科、7高中職業科、8高職
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值

*畢業年 0跳答或不適用 98拒答
replace grad_y=9999 if grad_y==0|grad_y==996
*目前是否有工作 1有 2無->3無
replace job_now=3 if job_now==2
*第一次正式工作年 0跳答或不適用 99缺漏值
replace job1_year=9999 if job1_year==996
*找工作月數/週數 95超過95個月 96不知道 98拒答 99缺漏值
replace f_month=9999 if f_month==96|f_month==98|f_month==99
replace f_week=9999 if f_week==99 //6不知道 8拒答 9缺漏值
*入退伍年 0跳答或不適用 996服役中
replace sol_eyear=9990 if sol_eyear==996
*9990 服役中

save "D:\家庭動態調查\主樣本\data\psfd_rci2007.dta",replace

foreach i in 2009 2011{
use "D:\家庭動態調查\主樣本\原始檔\rci`i'.dta",clear
gen survey="rci"
gen survey_plan="rci`i'"
rename x01 number
gen year=`i'
rename x03z01 month 
rename x05 location
rename a01 sex
rename a02z01 b_year
rename a02z02 b_month
rename b01 edu
rename b02z01 grad
rename b02z02 grad_y
rename c25a soldier
rename c25c01 sol_syear
rename c25c02 sol_smonth
rename c25c03 sol_eyear
rename c25c04 sol_emonth
rename c16 job1_year
rename c01 job_now
rename c07 job_whour //每週工時
rename c02 job_thisyear
rename c10 job_lastyear
rename c15z01 job_find
rename c15z02 f_month
rename c15z03 f_week
keep number year month location sex b_year b_month /*
*/edu grad grad_y /*
*/job_now job_whour job_thisyear job_lastyear job_find f_month f_week job1_year /*
*/soldier sol_syear sol_smonth sol_eyear sol_emonth survey survey_plan 
*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4|edu==5 //4初(國)中
replace eduy=12 if edu==6|edu==7|edu==8|edu==16 //6高中普通科、7高中職業科、8高職
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值

*畢業年 0跳答或不適用 98拒答
replace grad_y=9999 if grad_y==0|grad_y==996
*第一次正式工作年 0跳答或不適用 996不知道 999缺漏值
replace job1_year=9999 if job1_year==996|job1_year==999
*現在工作每週工時
replace job_whour=9999 if job_whour==991|job_whour==996|job_whour==998
*找工作月數/週數 95超過95個月 96不知道 98拒答 99缺漏值
replace f_month=9999 if f_month==96|f_month==98|f_month==99
replace f_week=9999 if f_week==6|f_week==8|f_week==9 //6不知道 8拒答 9缺漏值
*入退伍年 0跳答或不適用 996不知道/服役中
replace sol_eyear=9990 if sol_eyear==996
*9990 服役中

save "D:\家庭動態調查\主樣本\data\psfd_rci`i'.dta",replace

}

use "D:\家庭動態調查\主樣本\原始檔\rci2014.dta",clear
gen survey="rci"
gen survey_plan="rci2014"
rename x01 number
rename x02 year
rename x03z01 month 
rename x05 location
rename a01 sex
rename a02z01 b_year
rename a02z02 b_month
rename b01 edu
rename b02z01 grad
rename b02z02 grad_y
rename c26a soldier
rename c26c01 sol_syear
rename c26c02 sol_smonth
rename c26c03 sol_eyear
rename c26c04 sol_emonth
rename c12 job1_year
rename c01 job_now
rename c05b job_whour //每週工時
rename c11a01 job_find
rename c11a02 f_month
rename c11a03 f_week
keep number year month location sex b_year b_month /*
*/edu grad grad_y /*
*/job_now job_whour job_find f_month f_week job1_year /*
*/soldier sol_syear sol_smonth sol_eyear sol_emonth survey survey_plan 
*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4|edu==5 //4初(國)中
replace eduy=12 if edu==6|edu==7|edu==8|edu==16 //6高中普通科、7高中職業科、8高職、16高職普通科
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值

*畢業年 0跳答或不適用 98拒答
replace grad_y=9999 if grad_y==0|grad_y==996
*第一次正式工作年 0跳答或不適用 996不知道 999缺漏值
replace job1_year=9999 if job1_year==996|job1_year==999
*現在工作每週工時
replace job_whour=9999 if job_whour==991|job_whour==996|job_whour==998|job_whour==999
*找工作月數/週數 95超過95個月 96不知道 98拒答 99缺漏值
replace f_month=9999 if f_month==96|f_month==98|f_month==99
replace f_week=9999 if f_week==6|f_week==8|f_week==9 //6不知道 8拒答 9缺漏值
*入退伍年 0跳答或不適用 996不知道 995服役中
replace sol_eyear=9999 if sol_eyear==996
replace sol_eyear=9990 if sol_eyear==995
*9990 服役中
*入退伍月 0跳答或不適用 95服役中 96不知道

save "D:\家庭動態調查\主樣本\data\psfd_rci2014.dta",replace

use "D:\家庭動態調查\主樣本\原始檔\rci2016.dta",clear
gen survey="rci"
gen survey_plan="rci2016"
rename x01 number
rename x02 year
rename x03z01 month 
rename a01 sex
rename a02a01 b_year
rename a02a02 b_month
rename b01 edu
rename b02z01 grad
rename b02z02 grad_y
rename c27a soldier
rename c27c01 sol_syear
rename c27c02 sol_smonth
rename c27c03 sol_eyear
rename c27c04 sol_emonth
rename c13b job1_year
rename c02z01 job_now
rename c06b01 job_whour //每週工時
rename c12a01 job_find
rename c12a02 f_month
rename c12a03 f_week
keep number year month sex b_year b_month /*
*/edu grad grad_y /*
*/job_now job_whour job_find f_month f_week job1_year /*
*/soldier sol_syear sol_smonth sol_eyear sol_emonth survey survey_plan 
*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4|edu==5 //4初(國)中
replace eduy=12 if edu==6|edu==7|edu==8|edu==16 //6高中普通科、7高中職業科、8高職、16高職普通科
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值

*畢業年 0跳答或不適用 98拒答
replace grad_y=9999 if grad_y==0|grad_y==996
*第一次正式工作年 0跳答或不適用 996不知道 999缺漏值
replace job1_year=9999 if job1_year==996|job1_year==999
*現在工作每週工時
replace job_whour=9999 if job_whour==991|job_whour==996|job_whour==998
*找工作月數/週數 95超過95個月 96不知道 98拒答 99缺漏值
replace f_month=9999 if f_month==96|f_month==98|f_month==99
replace f_week=9999 if f_week==6|f_week==8|f_week==9 //6不知道 8拒答 9缺漏值
*入退伍年 0跳答或不適用 996不知道 995服役中
replace sol_syear=9999 if sol_syear==996
replace sol_eyear=9999 if sol_eyear==996
replace sol_eyear=9990 if sol_eyear==995
*9990 服役中
*入退伍月 0跳答或不適用 95服役中 96不知道

save "D:\家庭動態調查\主樣本\data\psfd_rci2016.dta",replace

use "D:\家庭動態調查\主樣本\原始檔\rci2018.dta",clear
gen survey="rci"
gen survey_plan="rci2018"
rename x01 number
rename x02 year
rename x03z01 month 
rename a01 sex
rename a02a01 b_year
rename a02a02 b_month
rename b01 edu
rename b02z01 grad
rename b02z02 grad_y
rename c27a soldier
rename c27c01 sol_syear
rename c27c02 sol_smonth
rename c27c03 sol_eyear
rename c27c04 sol_emonth
rename c13b job1_year
rename c02 job_now
rename c06b job_whour //每週工時
rename c12a01 job_find
rename c12a02 f_month
rename c12a03 f_week
keep number year month sex b_year b_month /*
*/edu grad grad_y /*
*/job_now job_whour job_find f_month f_week job1_year /*
*/soldier sol_syear sol_smonth sol_eyear sol_emonth survey survey_plan 
*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4|edu==5 //4初(國)中
replace eduy=12 if edu==6|edu==7|edu==8|edu==16 //6高中普通科、7高中職業科、8高職、16高職普通科
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值

*畢業年 0跳答或不適用 98拒答
replace grad_y=9999 if grad_y==0|grad_y==996
*第一次正式工作年 0跳答或不適用 996不知道 999缺漏值
replace job1_year=9999 if job1_year==996|job1_year==999
*找工作月數/週數
*入退伍年 0跳答或不適用 996不知道 995服役中
replace sol_syear=9999 if sol_syear==996
replace sol_eyear=9999 if sol_eyear==996
replace sol_eyear=9990 if sol_eyear==995
*9990 服役中
*入退伍月 0跳答或不適用 95服役中 96不知道

save "D:\家庭動態調查\主樣本\data\psfd_rci2018.dta",replace

use "D:\家庭動態調查\主樣本\原始檔\rci2020.dta",clear
gen survey="rci"
gen survey_plan="rci2020"
rename x01 number
gen year=2020
rename x03z01 month 
rename a01 sex
rename a02a01 b_year
rename a02a02 b_month
rename b01 edu
rename b02a grad
rename b02b grad_y
rename w02a soldier
rename c27b02 age27 //是否年滿27歲
rename c27c01 sol_syear
rename c27c02 sol_smonth
rename c27c03 sol_eyear
rename c27c04 sol_emonth
rename c27d01 sol_2stage //是否兩階段完成兵役
rename c27d06 sol_syear_2 //兩階段入伍年
rename c27d07 sol_smonth_2
rename c27d08 sol_eyear_2
rename c27d09 sol_emonth_2
rename c27d10 sol_syear_1 //一次完成入伍年
rename c27d11 sol_smonth_1
rename c27d12 sol_eyear_1
rename c27d13 sol_emonth_1
rename c13b job1_year
rename w03 job_now
rename w06g job_whour //每週工時
rename w18a01 job_find
rename w18a02 f_month
rename w18a03 f_week
keep number year month sex b_year b_month age27 /*
*/edu grad grad_y /*
*/job_now job_whour job_find f_month f_week job1_year /*
*/soldier sol_syear sol_smonth sol_eyear sol_emonth survey survey_plan /*
*/sol_2stage sol_syear_2 sol_smonth_2 sol_eyear_2 sol_emonth_2 sol_syear_1 sol_smonth_1 sol_eyear_1 sol_emonth_1
*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4|edu==5 //4初(國)中
replace eduy=12 if edu==6|edu==7|edu==8|edu==16 //6高中普通科、7高中職業科、8高職、16高職普通科
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值

*畢業年 0跳答或不適用 98拒答
replace grad_y=9999 if grad_y==0|grad_y==996
*第一次正式工作年 0跳答或不適用 996不知道 999缺漏值 998拒答
replace job1_year=9999 if job1_year==996|job1_year==998|job1_year==999
*現在工作每週工時
replace job_whour=9999 if job_whour==991|job_whour==996|job_whour==998|job_whour==999
*找工作月數/週數 95超過95個月 96不知道 98拒答 99缺漏值
replace f_month=9999 if f_month==96|f_month==98|f_month==99
replace f_week=9999 if f_week==6|f_week==8|f_week==9 //6不知道 8拒答 9缺漏值
*sol_2stage 1兩階段 2一次完成
*入退伍年 0跳答或不適用 996不知道 995服役中 999遺漏值
replace sol_syear=9999 if sol_syear==996
replace sol_eyear=9999 if sol_eyear==999

replace sol_syear_2=9999 if sol_syear_2==999
replace sol_eyear_2=9999 if sol_eyear_2==999
replace sol_eyear_1=9990 if sol_eyear_1==995
*9990 服役中
*入退伍月 0跳答或不適用 95服役中 96不知道 99遺漏值

save "D:\家庭動態調查\主樣本\data\psfd_rci2020.dta",replace

////////////////////////////////////////////////////////////////////////
*主樣本ri
use "D:\家庭動態調查\主樣本\原始檔\ri1999.dta" ,clear
gen survey="ri"
gen survey_plan="ri1999"
rename x01 number
rename x02 year
rename x02z01 month
rename x06 location
rename a01 sex
rename a02 b_year
rename b01 edu
rename b02z02 grad
rename b02z01 grad_y
rename c15 job1_year
rename c01 job_now
rename c02 job_thisyear
rename c10 job_lastyear
rename c07 job_whour //每週工時
keep number year month sex b_year /*
*/edu grad grad_y /*
*/job_now job_whour job_thisyear job_lastyear job1_year /*
*/survey survey_plan 
*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4|edu==5 //4初(國)中、5初職
replace eduy=12 if edu==6|edu==7|edu==8 //6高中普通科、7高中職業科、8高職
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值

*畢業年 0跳答或不適用 96不知道 99缺漏值
replace grad_y=9999 if grad_y==0|grad_y==96|grad_y==98|grad_y==99
*目前是否有工作 1有 2無 -> 1有 2有 3無
replace job_now=3 if job_now==2
*第一次正式工作年 0跳答或不適用 96不知道 97其他 98拒答 99缺漏值
replace job1_year=9999 if job1_year==96|job1_year==97|job1_year==98|job1_year==99
*現在工作每週工時 95超過上限值
replace job_whour=9999 if job_whour==996|job_whour==997|job_whour==998|job_whour==999
replace job_whour=9990 if job_whour==995

save "D:\家庭動態調查\主樣本\data\psfd_ri1999.dta",replace

use "D:\家庭動態調查\主樣本\原始檔\ri2000.dta" ,clear
gen survey="ri"
gen survey_plan="ri2000"
rename x01 number
rename x02 year
rename x02z01 month
rename a01 sex
rename a02 b_year
rename b01 edu
rename b02z02 grad
rename b02z01 grad_y
rename c30z01 sol_sage //幾歲入伍
rename c30z02 sol_eage //幾歲退伍
rename c30z03 sol_ty //服役幾年
rename c30z04 sol_tm //服役幾月
rename c16 job1_year
rename c01 job_now
rename c07 job_whour //每週工時
rename c02 job_thisyear
rename c10 job_lastyear
rename c15z01 job_find
rename c15z02 f_month
rename c15z03 f_week
keep number year month sex b_year /*
*/edu grad grad_y /*
*/job_now job_whour job_thisyear job_lastyear job_find f_month f_week job1_year /*
*/sol_sage sol_eage sol_ty sol_tm survey survey_plan 
*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4|edu==5 //4初(國)中、5初職
replace eduy=12 if edu==6|edu==7|edu==8|edu==16 //6高中普通科、7高中職業科、8高職
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值

*畢業年 0跳答或不適用 96不知道 99缺漏值
replace grad_y=9999 if grad_y==0|grad_y==96|grad_y==99
*目前是否有工作 1有 2無
replace job_now=3 if job_now==2
*第一次正式工作年 0跳答或不適用 96不知道 97其他 98拒答 99缺漏值
replace job1_year=9999 if job1_year==96|job1_year==97|job1_year==98|job1_year==99
*現在工作每週工時 95超過上限值
replace job_whour=9999 if job_whour==996|job_whour==997|job_whour==998|job_whour==999
replace job_whour=9990 if job_whour==995
*找工作月數/週數 95超過上限值 96不知道 98拒答 99缺漏值
replace f_month=9999 if f_month==96|f_month==98|f_month==99
replace f_month=9990 if f_month==95
replace f_week=9999 if f_week==96|f_week==98|f_week==99 //6不知道 8拒答 9缺漏值
*幾歲入退伍 0跳答或不適用 96不知道 97其他 98拒答 99缺漏值
replace sol_sage=9999 if sol_sage==96|sol_sage==97|sol_sage==98|sol_sage==99
replace sol_eage=9999 if sol_eage==96|sol_eage==97|sol_eage==98|sol_eage==99
*服役幾年幾月 0跳答或不適用 96不知道 97其他 98拒答 99缺漏值
replace sol_ty=9999 if sol_ty==96|sol_ty==97|sol_ty==98|sol_ty==99
replace sol_tm=9999 if sol_tm==96|sol_tm==97|sol_tm==98|sol_tm==99

save "D:\家庭動態調查\主樣本\data\psfd_ri2000.dta",replace

use "D:\家庭動態調查\主樣本\原始檔\ri2003.dta" ,clear
gen survey="ri"
gen survey_plan="ri2003"
rename x01 number
gen year=2003
rename a01 sex
rename a02 b_year
rename b01 edu
rename b02z2 grad
rename b02z1 grad_y
rename c25a soldier
rename c25b1 sol_syear
rename c25b2 sol_eyear
rename c16 job1_year
rename c01 job_now
rename c07 job_whour //每週工時
rename c02 job_thisyear
rename c10 job_lastyear
rename c15z1 job_find
rename c15z2 f_month
rename c15z3 f_week
keep number year sex b_year /*
*/edu grad grad_y /*
*/job_now job_whour job_thisyear job_lastyear job_find f_month f_week job1_year /*
*/soldier sol_syear sol_eyear survey survey_plan 
*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4|edu==5 //4初(國)中、
replace eduy=12 if edu==6|edu==7|edu==8|edu==16 //6高中普通科、7高中職業科、8高職
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值

*畢業年 0跳答或不適用 98拒答
replace grad_y=9999 if grad_y==0|grad_y==98|grad_y==99
*目前是否有工作 1有 2無
replace job_now=3 if job_now==2
*第一次正式工作年 0跳答或不適用 96不知道 97其他 98拒答 99缺漏值
replace job1_year=9999 if job1_year==96|job1_year==97|job1_year==98|job1_year==99
*現在工作每週工時 95超過上限值
replace job_whour=9999 if job_whour==991|job_whour==992|job_whour==996|job_whour==998
replace job_whour=9990 if job_whour==995
*找工作月數/週數 95超過上限值 96不知道 98拒答 99缺漏值
replace f_month=9999 if f_month==96|f_month==98|f_month==99
replace f_month=9990 if f_month==95
replace f_week=9999 if f_week==96|f_week==97|f_week==98|f_week==99 //6不知道 8拒答 9缺漏值
*入退伍年 0跳答或不適用 96不知道 99缺漏值
replace sol_syear=9999 if sol_syear==96|sol_syear==99
replace sol_eyear=9999 if sol_eyear==96|sol_eyear==99

save "D:\家庭動態調查\主樣本\data\psfd_ri2003.dta",replace

use "D:\家庭動態調查\主樣本\原始檔\ri2009.dta" ,clear
gen survey="ri"
gen survey_plan="ri2009"
rename x01 number
rename x02 year
rename x03z01 month 
rename a01 sex
rename a02z01 b_year
rename a02z02 b_month
rename b01 edu
rename b02z01 grad
rename b02z02 grad_y
rename c25a soldier
rename c25c01 sol_syear
rename c25c02 sol_smonth
rename c25c03 sol_eyear
rename c25c04 sol_emonth
rename c16 job1_year
rename c01 job_now
rename c07 job_whour //每週工時
rename c02 job_thisyear
rename c10 job_lastyear
rename c15z01 job_find
rename c15z02 f_month
rename c15z03 f_week
keep number year month sex b_year b_month /*
*/edu grad grad_y /*
*/job_now job_whour job_thisyear job_lastyear job_find f_month f_week job1_year /*
*/soldier sol_syear sol_smonth sol_eyear sol_emonth survey survey_plan 
*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4|edu==5 //4初(國)中、
replace eduy=12 if edu==6|edu==7|edu==8|edu==16 //6高中普通科、7高中職業科、8高職
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值

*畢業年 0跳答或不適用 98拒答
replace grad_y=9999 if grad_y==0|grad_y==996
*目前是否有工作 1.2有 3無
*第一次正式工作年 0跳答或不適用 996不知道 999缺漏值
replace job1_year=9999 if job1_year==996|job1_year==999
*現在工作每週工時 95超過上限值
replace job_whour=9999 if job_whour==991|job_whour==999
replace job_whour=9990 if job_whour==995
*找工作月數/週數 95超過上限值 96不知道 98拒答 99缺漏值
replace f_month=9999 if f_month==96|f_month==98|f_month==99
replace f_month=9990 if f_month==95
replace f_week=9999 if f_week==9|f_week==9 //6不知道 8拒答 9缺漏值
*入退伍年 0跳答或不適用 996不知道/服役中 998拒答 999缺漏值
replace sol_syear=9999 if sol_syear==996|sol_syear==998|sol_syear==999
replace sol_eyear=9999 if sol_eyear==996|sol_eyear==998|sol_eyear==999
*入退伍月 0跳答或不適用 96不知道 98拒答 99遺漏值

save "D:\家庭動態調查\主樣本\data\psfd_ri2009.dta",replace

use "D:\家庭動態調查\主樣本\原始檔\ri2016.dta" ,clear
gen survey="ri"
gen survey_plan="ri2016"
rename x01 number
rename x02 year
rename x03z01 month 
rename a01 sex
rename a02a01 b_year
rename a02a02 b_month
rename b01 edu
rename b02z01 grad
rename b02z02 grad_y
rename c27a soldier
rename c27c01 sol_syear
rename c27c02 sol_smonth
rename c27c03 sol_eyear
rename c27c04 sol_emonth
rename c13b job1_year
rename c02z01 job_now
rename c06b01 job_whour //每週工時
rename c12a01 job_find
rename c12a02 f_month
rename c12a03 f_week
keep number year month sex b_year b_month /*
*/edu grad grad_y /*
*/job_now job_whour job_find f_month f_week job1_year /*
*/soldier sol_syear sol_smonth sol_eyear sol_emonth survey survey_plan 
*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4|edu==5 //4初(國)中
replace eduy=12 if edu==6|edu==7|edu==8|edu==16 //6高中普通科、7高中職業科、8高職、16高職普通科
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值

*畢業年 0跳答或不適用 996不知道 999遺漏值
replace grad_y=9999 if grad_y==0|grad_y==996|grad_y==999
*目前是否有工作 1.2有 3無
*第一次正式工作年 0跳答或不適用 996不知道 998拒答 999缺漏值
replace job1_year=9999 if job1_year==996|job1_year==998|job1_year==999
*現在工作每週工時 95超過上限值
replace job_whour=9999 if job_whour==996|job_whour==997|job_whour==998|job_whour==999
replace job_whour=9990 if job_whour==995
*找工作月數/週數 95超過上限值 96不知道 98拒答 99缺漏值
replace f_month=9999 if f_month==96|f_month==98|f_month==99
replace f_month=9990 if f_month==95
replace f_week=9999 if f_week==6|f_week==9 //6不知道 8拒答 9缺漏值
*入退伍年 0跳答或不適用 996不知道/服役中 998拒答 999缺漏值
replace sol_syear=9999 if sol_syear==996|sol_syear==998|sol_syear==999
replace sol_eyear=9999 if sol_eyear==996|sol_eyear==998|sol_eyear==999
replace sol_eyear=9990 if sol_eyear==995
*入退伍月 0跳答或不適用 95服役中 96不知道 98拒答 99遺漏值

save "D:\家庭動態調查\主樣本\data\psfd_ri2016.dta",replace

////////////////////////////////////////////////////////////////////////
*主樣本追蹤rr
use "D:\家庭動態調查\主樣本追蹤\原始檔\RR2000.dta" ,clear
gen survey="RR"
gen survey_plan="RR2000"
rename x01 number
rename x02 year
rename x02z01 month 
rename x06 location
rename a01 sex
rename a02 b_year
rename a03 edu
*無畢業資訊
rename b04e jun_grady //國中畢業年
rename b05e sen_grady
rename b06e coll_grady
rename b07c mast_grady
rename b08a soldier
rename b08b01 sol_syear
rename b08b02 sol_eyear
rename b09 job1_year
rename c01 job_now
rename c07 job_whour //每週工時
rename c16z01 job_find
rename c16z02 f_week
keep number year month location sex b_year /*
*/edu jun_grady sen_grady coll_grady mast_grady /*
*/job_now job_whour job_find f_week job1_year /*
*/soldier sol_syear sol_eyear survey survey_plan 
*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4|edu==5 //4初(國)中、5初職
replace eduy=12 if edu==6|edu==7|edu==8|edu==16 //6高中普通科、7高中職業科、8高職
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值

*畢業年 0跳答或不適用 96不知道 98拒答 99缺漏值
replace jun_grady=9999 if jun_grady==96|jun_grady==98|jun_grady==99
replace sen_grady=9999 if sen_grady==96|sen_grady==98|sen_grady==99
replace coll_grady=9999 if coll_grady==96|coll_grady==99
replace mast_grady=9999 if mast_grady==96|mast_grady==97
gen grad_y=9999
replace grad_y=mast_grady if mast_grady!=0&mast_grady!=9999
replace grad_y=coll_grady if coll_grady!=0&coll_grady!=9999&grad_y==9999
replace grad_y=sen_grady if sen_grady!=0&sen_grady!=9999&grad_y==9999
replace grad_y=jun_grady if jun_grady!=0&jun_grady!=9999&grad_y==9999

*目前是否有工作 1有 2無->3無
replace job_now=3 if job_now==2
*第一次正式工作年 0跳答或不適用 96不知道 99缺漏值
replace job1_year=9999 if job1_year==96|job1_year==99
*現在工作每週工時 95超過上限值
replace job_whour=9999 if job_whour==996|job_whour==997|job_whour==998|job_whour==999
replace job_whour=9990 if job_whour==995
*找工作週數 95超過上限值 96不知道 97其他 98拒答 99缺漏值
replace f_week=9999 if f_week==96|f_week==97|f_week==99 //6不知道 8拒答 9缺漏值
*入退伍年 0跳答或不適用 96不知道 99缺漏值
replace sol_syear=9999 if sol_syear==96|sol_syear==99
replace sol_eyear=9999 if sol_eyear==96|sol_eyear==99

save "D:\家庭動態調查\主樣本追蹤\data\psfd_RR2000.dta",replace

use "D:\家庭動態調查\主樣本追蹤\原始檔\RR2001_2.dta" ,clear
gen survey="RR"
gen survey_plan="RR2001_2"
rename x01 number
rename x02 year
rename x02z01 month 
rename x05 location
rename a01 sex
rename a02 b_year
rename a03 edu
*無畢業資訊
rename b04e jun_grady //國中畢業年
rename b05e sen_grady
rename b06e coll_grady
rename b07c mast_grady
rename b08a soldier
rename b08b01 sol_syear
rename b08b02 sol_eyear
rename b09 job1_year
rename c01a job_sit
rename c08 job_whour //每週工時
rename c16z01 job_find
rename c16z02 f_week
keep number year month location sex b_year /*
*/edu jun_grady sen_grady coll_grady mast_grady /*
*/job_sit job_whour job_find f_week job1_year /*
*/soldier sol_syear sol_eyear survey survey_plan 
*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4|edu==5 //4初(國)中、5初職
replace eduy=12 if edu==6|edu==7|edu==8|edu==16 //6高中普通科、7高中職業科、8高職
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值

*畢業年 0跳答或不適用 96不知道 98拒答 99缺漏值
replace jun_grady=9999 if jun_grady==96|jun_grady==98|jun_grady==99
replace sen_grady=9999 if sen_grady==96|sen_grady==98|sen_grady==99
replace coll_grady=9999 if coll_grady==96|coll_grady==99
replace mast_grady=9999 if mast_grady==96|mast_grady==97
gen grad_y=9999
replace grad_y=mast_grady if mast_grady!=0&mast_grady!=9999&grad_y==9999
replace grad_y=coll_grady if coll_grady!=0&coll_grady!=9999&grad_y==9999
replace grad_y=sen_grady if sen_grady!=0&sen_grady!=9999&grad_y==9999
replace grad_y=jun_grady if jun_grady!=0&jun_grady!=9999&grad_y==9999
*第一次正式工作年 0跳答或不適用 96不知道 99缺漏值
replace job1_year=9999 if job1_year==96|job1_year==99
*現在工作每週工時 95超過上限值
replace job_whour=9999 if job_whour==991|job_whour==996|job_whour==997|job_whour==998|job_whour==999
replace job_whour=9990 if job_whour==995
*找工作週數 95超過上限值 96不知道 98拒答 99缺漏值
replace f_week=9999 if f_week==96|f_week==98|f_week==99 //6不知道 8拒答 9缺漏值
replace f_week=9990 if f_week==95
*入退伍年 0跳答或不適用 96不知道 98拒答 99缺漏值
replace sol_syear=9999 if sol_syear==96|sol_syear==98|sol_syear==99
replace sol_eyear=9999 if sol_eyear==96|sol_eyear==98|sol_eyear==99

save "D:\家庭動態調查\主樣本追蹤\data\psfd_RR2001_2.dta",replace

use "D:\家庭動態調查\主樣本追蹤\原始檔\RR2001_3.dta" ,clear
gen survey="RR"
gen survey_plan="RR2001_3"
rename x01 number
gen year=2001
rename x02z01 month 
rename x05 location
rename a03a job_sit 
rename a08 job_whour //每週工時
*無教育資訊
keep number year month location job_sit job_whour survey survey_plan 
*現在工作每週工時 95超過上限值
replace job_whour=9999 if job_whour==991|job_whour==996|job_whour==997|job_whour==998|job_whour==999
replace job_whour=9990 if job_whour==995

save "D:\家庭動態調查\主樣本追蹤\data\psfd_RR2001_3.dta",replace

use "D:\家庭動態調查\主樣本追蹤\原始檔\RR2002.dta" ,clear
gen survey="RR"
gen survey_plan="RR2002"
rename x01 number
rename x02 year
rename x02z01 month 
rename x05 location
*無教育資訊
rename a03a job_sit 
rename a09 job_whour //每週工時
rename a13a01 job_find
rename a13a02 f_month
rename a13a03 f_week
keep number year month location job_sit job_whour job_find f_month f_week survey survey_plan 
*找工作月數/週數 92無法估計 95超過95個月 96不知道
replace f_month=9999 if f_month==92|f_month==96
replace f_week=9999 if f_week==92|f_week==96
*現在工作每週工時 95超過上限值
replace job_whour=9999 if job_whour==991|job_whour==996|job_whour==992|job_whour==998|job_whour==999
replace job_whour=9990 if job_whour==995

save "D:\家庭動態調查\主樣本追蹤\data\psfd_RR2002.dta",replace

use "D:\家庭動態調查\主樣本追蹤\原始檔\RR2003.dta" ,clear
gen survey="RR"
gen survey_plan="RR2003"
rename x01 number
gen year=2003
rename x05 location
rename a01 sex
rename b01 b_year
rename b02 age
*無教育資訊
rename b05z01 job1_age
keep number year location sex b_year age job1_age survey survey_plan
*第一次正式工作年 0跳答或不適用 98拒答
replace job1_age=9999 if job1_age==98

save "D:\家庭動態調查\主樣本追蹤\data\psfd_RR2003.dta",replace

use "D:\家庭動態調查\主樣本追蹤\原始檔\RR2004.dta" ,clear
gen survey="RR"
gen survey_plan="RR2004"
*drop if x02==.&a03==.
rename x01 number
gen year=2004
rename g17z01 month 
rename x06 location
*無教育資訊
rename a04b01 nojob_time
rename a04b02 nojob_long
rename a03 job_thisyear
rename a12 job_lastyear
rename a09 job_whour //每週工時
rename a23a01 job_find
rename a23a02 f_month
rename a23a03 f_week
keep number year month location /*
*/nojob_time nojob_long job_thisyear job_lastyear job_whour job_find f_month f_week survey survey_plan 
*找工作月數/週數 95超過上限值 96不知道 99缺漏值
replace f_month=9999 if f_month==96|f_month==99
replace f_month=9990 if f_month==95
replace f_week=9999 if f_week==96|f_week==99
replace f_week=0 if f_week==95
*現在工作每週工時 95超過上限值
replace job_whour=9999 if job_whour==991|job_whour==996|job_whour==997|job_whour==998|job_whour==999
replace job_whour=9990 if job_whour==995

save "D:\家庭動態調查\主樣本追蹤\data\psfd_RR2004.dta",replace

use "D:\家庭動態調查\主樣本追蹤\原始檔\RR2005.dta" ,clear
gen survey="RR"
gen survey_plan="RR2005"
rename x01 number
rename x02 year
rename x03z01 month 
*無教育資訊
rename a11a job_sit
rename a17 job_whour //每週工時
rename c03a01 job_lastyear
rename a21a01 job_find
rename a21a02 f_month
rename a21a03 f_week
keep number year month /*
*/job_whour job_lastyear job_find f_month f_week job_sit survey survey_plan 

*現在工作每週工時 95超過上限值
replace job_whour=9999 if job_whour==991|job_whour==996|job_whour==992|job_whour==998|job_whour==999
replace job_whour=9990 if job_whour==995
*找工作月數/週數 95超過10年 96不知道
replace f_month=9999 if f_month==96
replace f_month=9991 if f_month==95 //超過10年
replace f_week=9999 if f_week==96
replace f_week=0 if f_week==95 //超過10年

save "D:\家庭動態調查\主樣本追蹤\data\psfd_RR2005.dta",replace

use "D:\家庭動態調查\主樣本追蹤\原始檔\RR2006.dta" ,clear
gen survey="RR"
gen survey_plan="RR2006"
rename z01 number
rename z02 year
rename x01z01 month 
rename z04b location
rename a01 sex
rename a02 b_year
*無教育資訊
rename a08a01 job_sit
rename a07 job_now
rename a14 job_whour //每週工時
rename a21a01 job_find
rename a21a02 f_month
rename a21a03 f_week
keep number year month location sex b_year /*
*/job_now job_whour job_find f_month f_week job_sit survey survey_plan 
*現在工作每週工時 95超過上限值
replace job_whour=9999 if job_whour==991|job_whour==996|job_whour==992|job_whour==998|job_whour==999
replace job_whour=9990 if job_whour==995
*找工作月數/週數 95超過95個月 96不知道 99缺漏值

save "D:\家庭動態調查\主樣本追蹤\data\psfd_RR2006.dta",replace

use "D:\家庭動態調查\主樣本追蹤\原始檔\RR2007.dta" ,clear
gen survey="RR"
gen survey_plan="RR2007"
rename x01 number
rename x02 year
rename x03z01 month 
rename x05 location
rename a01 sex
rename a02a b_year
*無教育資訊
rename a05 job_now
rename a11a job_whour //每週工時
rename a15b01 job_find
rename a15b02 f_month
rename a15b03 f_week
keep number year month location sex b_year /*
*/job_now job_whour job_find f_month f_week survey survey_plan 
*目前是否有工作 1有 2無
replace job_now=3 if job_now==2
*現在工作每週工時 95超過上限值
replace job_whour=9999 if job_whour==991|job_whour==996|job_whour==997|job_whour==998|job_whour==999
replace job_whour=9990 if job_whour==995
*找工作月數/週數 95超過95個月 96不知道
replace f_month=9999 if f_month==96
replace f_week=9999 if f_week==96

save "D:\家庭動態調查\主樣本追蹤\data\psfd_RR2007.dta",replace

use "D:\家庭動態調查\主樣本追蹤\原始檔\RR2008.dta" ,clear
gen survey="RR"
gen survey_plan="RR2008"
rename x01 number
rename x02 year
rename x03z01 month 
rename x05 location
rename a01 sex
rename a02a b_year
*無教育資訊
rename a06z02 job_lastyear
rename a05 job_now
rename a11a job_whour //每週工時
rename a15b01 job_find
rename a15b02 f_month
rename a15b03 f_week
keep number year month location sex b_year /*
*/job_now job_whour job_lastyear job_find f_month f_week survey survey_plan 
*現在工作每週工時 95超過上限值
replace job_whour=9999 if job_whour==991|job_whour==996|job_whour==997|job_whour==998|job_whour==999
replace job_whour=9990 if job_whour==995
*找工作月數/週數 95超過95個月 96不知道
replace f_month=9999 if f_month==99
replace f_week=9999 if f_week==6|f_week==9 //6不知道 9缺漏值

save "D:\家庭動態調查\主樣本追蹤\data\psfd_RR2008.dta",replace

use "D:\家庭動態調查\主樣本追蹤\原始檔\RR2009.dta" ,clear
gen survey="RR"
gen survey_plan="RR2009"
rename x01 number
rename x02 year
rename x03z01 month 
rename x05 location
rename a01 sex
rename a02a b_year
rename a03c edu
*無畢業年
rename a06z02 job_lastyear
rename a05 job_now
rename a11a job_whour //每週工時
rename a15b01 job_find
rename a15b02 f_month
rename a15b03 f_week
keep number year month location sex b_year edu /*
*/job_now job_whour job_lastyear job_find f_month f_week survey survey_plan 
*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4|edu==5 //4初(國)中、5初職
replace eduy=12 if edu==6|edu==7|edu==8|edu==16 //6高中普通科、7高中職業科、8高職
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值
*現在工作每週工時 95超過上限值
replace job_whour=9999 if job_whour==991|job_whour==996|job_whour==997|job_whour==998|job_whour==999
replace job_whour=9990 if job_whour==995
*找工作月數/週數 96不知道
replace f_month=9999 if f_month==96
replace f_week=9999 if f_week==6|f_week==9 //6不知道

save "D:\家庭動態調查\主樣本追蹤\data\psfd_RR2009.dta",replace

use "D:\家庭動態調查\主樣本追蹤\原始檔\RR2010.dta" ,clear
gen survey="RR"
gen survey_plan="RR2010"
rename x01 number
rename x02 year
rename x03z01 month 
rename x05 location
rename a01 sex
rename a02a b_year
rename a03c edu
*無畢業年
rename a06z02 job_lastyear
rename a05 job_now
rename a15a01 job_find
rename a11a job_whour //每週工時
rename a15a02 f_month
rename a15a03 f_week
keep number year month location sex b_year edu /*
*/job_now job_whour job_lastyear job_find f_month f_week survey survey_plan 
*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4|edu==5 //4初(國)中、5初職
replace eduy=12 if edu==6|edu==7|edu==8|edu==16 //6高中普通科、7高中職業科、8高職
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值
*現在工作每週工時 95超過上限值
replace job_whour=9999 if job_whour==991|job_whour==996|job_whour==997|job_whour==998|job_whour==999
replace job_whour=9990 if job_whour==995
*找工作月數/週數 95超過95個月 96不知道
replace f_month=9999 if f_month==96
replace f_week=9999 if f_week==6|f_week==9 //6不知道

save "D:\家庭動態調查\主樣本追蹤\data\psfd_RR2010.dta",replace

use "D:\家庭動態調查\主樣本追蹤\原始檔\RR2011.dta" ,clear
gen survey="RR"
gen survey_plan="RR2011"
rename x01 number
rename x02 year
rename x03z01 month 
rename x05 location
rename a01 sex
rename a02a b_year
rename a03c edu
*無畢業年
rename a06z02 job_lastyear
rename a05 job_now
rename a11a job_whour //每週工時
rename a15a01 job_find
rename a15a02 f_month
rename a15a03 f_week
keep number year month location sex b_year edu /*
*/job_now job_whour job_lastyear job_find f_month f_week survey survey_plan 
*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4|edu==5 //4初(國)中、5初職
replace eduy=12 if edu==6|edu==7|edu==8|edu==16 //6高中普通科、7高中職業科、8高職
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值
*現在工作每週工時 95超過上限值
replace job_whour=9999 if job_whour==991|job_whour==996|job_whour==997|job_whour==998|job_whour==999
replace job_whour=9990 if job_whour==995
*找工作月數/週數 95超過95個月 96不知道
replace f_month=9999 if f_month==96
replace f_week=9999 if f_week==6|f_week==9 //6不知道

save "D:\家庭動態調查\主樣本追蹤\data\psfd_RR2011.dta",replace

use "D:\家庭動態調查\主樣本追蹤\原始檔\RR2012.dta" ,clear
gen survey="RR"
gen survey_plan="RR2012"
rename x01 number
gen year=2012
rename x03z01 month 
rename x05 location
rename a01 sex
rename a02a01 b_year
rename a02a02 age
rename a03c edu
*無畢業年
rename a06z02 job_lastyear
rename a05 job_now
rename a11a job_whour //每週工時
rename a15a01 job_find
rename a15a02 f_month
rename a15a03 f_week
keep number year month location sex b_year age edu /*
*/job_now job_whour job_lastyear job_find f_month f_week survey survey_plan 
*實歲、出生年
replace age=9999 if age==96 //96不知道
replace b_year=9999 if b_year==96 //96不知道
*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4|edu==5 //4初(國)中、5初職
replace eduy=12 if edu==6|edu==7|edu==8|edu==16 //6高中普通科、7高中職業科、8高職
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值
*現在工作每週工時 95超過上限值
replace job_whour=9999 if job_whour==991|job_whour==996|job_whour==997|job_whour==998|job_whour==999
replace job_whour=9990 if job_whour==995
*找工作月數/週數 95超過95個月 96不知道 99缺漏值
replace f_month=9999 if f_month==96|f_month==99
replace f_week=9999 if f_week==6|f_week==9 //6不知道 9缺漏值

save "D:\家庭動態調查\主樣本追蹤\data\psfd_RR2012.dta",replace

use "D:\家庭動態調查\主樣本追蹤\原始檔\RR2014.dta" ,clear
gen survey="RR"
gen survey_plan="RR2014"
rename x01 number
rename x02 year
rename x03z01 month 
rename x05 location
rename a01 sex
rename a02a b_year
rename a03c edu
*無畢業年
rename a05 job_now
rename a09b job_whour //每週工時
rename a15a01 job_find
rename a15a02 f_month
rename a15a03 f_week
keep number year month location sex b_year edu /*
*/job_now job_whour job_find f_month f_week survey survey_plan 
*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4|edu==5 //4初(國)中、5初職
replace eduy=12 if edu==6|edu==7|edu==8|edu==16 //6高中普通科、7高中職業科、8高職
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值
*現在工作每週工時 95超過上限值
replace job_whour=9999 if job_whour==991|job_whour==996|job_whour==997|job_whour==998|job_whour==999
replace job_whour=9990 if job_whour==995
*找工作月數/週數 95超過95個月 96不知道 98拒答 99缺漏值
replace f_month=9999 if f_month==96|f_month==98|f_month==99
replace f_week=9999 if f_week==96|f_week==98|f_week==99 //6不知道 9缺漏值

save "D:\家庭動態調查\主樣本追蹤\data\psfd_RR2014.dta",replace

use "D:\家庭動態調查\主樣本追蹤\原始檔\RR2016.dta" ,clear
gen survey="RR"
gen survey_plan="RR2016"
rename x01 number
rename x02 year
rename x03z01 month 
rename x05 location
rename a01 sex
rename a02a b_year
rename a03c edu
*無畢業年
rename a05a soldier
rename a05c01 sol_syear
rename a05c02 sol_smonth
rename a05c03 sol_eyear
rename a05c04 sol_emonth
rename a06a01 job_now
rename a10b01 job_whour //每週工時
rename a16a01 job_find
rename a16a02 f_month
rename a16a03 f_week
keep number year month location sex b_year edu /*
*/job_now job_whour job_find f_month f_week /*
*/soldier sol_syear sol_smonth sol_eyear sol_emonth survey survey_plan 
*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4 //4初(國)中
replace eduy=12 if edu==5|edu==6|edu==7|edu==8 //5高中普通科、6高中職業科、7高職普通科 8高職職業科
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值

*現在工作每週工時 95超過上限值
replace job_whour=9999 if job_whour==991|job_whour==996|job_whour==997|job_whour==998|job_whour==999
replace job_whour=9990 if job_whour==995
*找工作月數/週數 95超過95個月 96不知道 98拒答 99缺漏值
replace f_month=9999 if f_month==96|f_month==98|f_month==99
replace f_week=9999 if f_week==6|f_week==8|f_week==9 //6不知道 8拒答 9缺漏值
*入退伍年 0跳答或不適用 996不知道/服役中 998拒答 999缺漏值
replace sol_syear=9999 if sol_syear==996|sol_syear==998|sol_syear==999
replace sol_eyear=9999 if sol_eyear==996|sol_eyear==998|sol_eyear==999
replace sol_eyear=9990 if sol_eyear==995
*入退伍月 0跳答或不適用 95服役中 96不知道 98拒答 99遺漏值

save "D:\家庭動態調查\主樣本追蹤\data\psfd_RR2016.dta",replace

use "D:\家庭動態調查\主樣本追蹤\原始檔\RR2018.dta" ,clear
gen survey="RR"
gen survey_plan="RR2018"
rename x01 number
rename x02 year
rename x03z01 month 
rename x05 location
rename a01 sex
rename a02a b_year
rename a02b b_month
rename a03a edu
rename a03b grad
*無畢業年
rename a05a soldier
rename a05c01 sol_syear
rename a05c02 sol_smonth
rename a05c03 sol_eyear
rename a05c04 sol_emonth
rename i13a job1 //是否曾回答第一份全職工作題組 1是 2否
rename i13b job1_year
rename a06a job_now
rename a14e job_whour //每週工時
rename a12f jleave //是否自願離開原來的工作? 3 從未工作過
rename a16a01 job_find
rename a12a01 job_sy //何時開始
rename a12a02 job_sm 
rename a16a02 f_month
rename a16a03 f_week
keep number year month location sex b_year b_month edu grad /*
*/job1 job1_year jleave job_now job_sy job_sm job_whour job_find f_month f_week /*
*/soldier sol_syear sol_smonth sol_eyear sol_emonth survey survey_plan 
*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4 //4初(國)中
replace eduy=12 if edu==5|edu==6|edu==7|edu==8 //5高中普通科、6高中職業科、7高職普通科、8高職職業科
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值

*第一次正式工作年 0跳答或不適用 996不知道 998拒答
replace job1_year=9999 if job1_year==996|job1_year==998
*現在工作每週工時 95超過上限值
replace job_whour=9999 if job_whour==991|job_whour==996|job_whour==997|job_whour==998|job_whour==999
replace job_whour=9990 if job_whour==995
*找工作月數/週數 95超過95個月 96不知道 98拒答 99缺漏值
replace f_month=9999 if f_month==96|f_month==98|f_month==99
replace f_week=9999 if f_week==6|f_week==8|f_week==9 //6不知道 8拒答 9缺漏值
*入退伍年 0跳答或不適用 996不知道/服役中 998拒答 999缺漏值
replace sol_syear=9999 if sol_syear==996|sol_syear==998|sol_syear==999
replace sol_eyear=9999 if sol_eyear==996|sol_eyear==998|sol_eyear==999
replace sol_eyear=9990 if sol_eyear==995
*入退伍月 0跳答或不適用 95服役中 96不知道 98拒答 99遺漏值

save "D:\家庭動態調查\主樣本追蹤\data\psfd_RR2018.dta",replace

use "D:\家庭動態調查\主樣本追蹤\原始檔\RR2020.dta" ,clear
gen survey="RR"
gen survey_plan="RR2020"
rename x01 number
rename x02 year
rename x03z01 month 
rename x05 location
rename a01 sex
rename a02a b_year
rename a02b b_month
rename a03a edu
rename a03b grad
rename a03c grad_y
rename a03d grad_age
rename w02a soldier
rename a05b01 sol_syear
rename a05b02 sol_smonth
rename a05b03 sol_eyear
rename a05b04 sol_emonth
rename a06 job1_year
rename w03 job_now
rename w11c job_whour //每週工時
rename w13a jleave
rename w10z01 job_sy //何時開始
rename w10z02 job_sm 
rename w18a01 job_find
rename w18a02 f_month
rename w18a03 f_week
keep number year month location sex b_year b_month /*
*/edu grad grad_y grad_age /*
*/job1_year jleave job_now job_sy job_sm job_whour job_find f_month f_week /*
*/soldier sol_syear sol_smonth sol_eyear sol_emonth survey survey_plan 
*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4 //4初(國)中
replace eduy=12 if edu==5|edu==6|edu==7|edu==8 //5高中普通科、6高中職業科、7高職普通科、8高職職業科
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值

*畢業年 0跳答或不適用 98拒答
replace grad_y=9999 if grad_y==0|grad_y==98|grad_y==99
*第一次正式工作年 0跳答或不適用 996不知道 998拒答
replace job1_year=9999 if job1_year==996|job1_year==998
*現在工作每週工時 95超過上限值
replace job_whour=9999 if job_whour==991|job_whour==996|job_whour==997|job_whour==998|job_whour==999
replace job_whour=9990 if job_whour==995
*找工作月數/週數 95超過95個月 96不知道 98拒答 99缺漏值
replace f_month=9999 if f_month==96|f_month==98|f_month==99
replace f_week=9999 if f_week==6|f_week==8|f_week==9 //6不知道 8拒答 9缺漏值
*入退伍年 0跳答或不適用 996不知道 998拒答 999缺漏值
replace sol_syear=9999 if sol_syear==996|sol_syear==998|sol_syear==999
replace sol_eyear=9999 if sol_eyear==996|sol_eyear==998|sol_eyear==999
replace sol_eyear=9990 if sol_eyear==995
*入退伍月 0跳答或不適用 95服役中 96不知道 98拒答 99遺漏值

save "D:\家庭動態調查\主樣本追蹤\data\psfd_RR2020.dta",replace

use "D:\家庭動態調查\主樣本追蹤\原始檔\RR2022.dta",clear
gen survey="RR"
gen survey_plan="RR2022"
rename x01 number
rename x02 year
rename x03z01 month 
rename a01 sex
rename x05 location
rename a02z01 b_year
rename a02z02 b_month
rename b01 edu
rename b02 grad
rename b03z01 grad_y
rename b03z02 grad_m
rename b04 grad_age
rename a17 soldier
rename a19z01 sol_2stage //是否兩階段完成兵役
rename a19z10 sol_syear_1 //一次完成入伍年
rename a19z11 sol_smonth_1
rename a19z12 sol_eyear_1
rename a19z13 sol_emonth_1
rename a19z06 sol_syear_2 //兩階段入伍年
rename a19z07 sol_smonth_2
rename a19z08 sol_eyear_2
rename a19z09 sol_emonth_2
rename c38z01 job1_year
rename c38z02 job1_month
rename c02r1 job_now
rename c09r1 job_now_full
rename c19r1 job_whour //每週工時
rename c22z01r1 job_sy //何時開始
rename c22z02r1 job_sm 
rename c20z07 job_last_survey //上次訪問時是否有工作
rename c24 jleave
rename c35z01r1 job_find
rename c35z02r1 f_month
rename c35z03r1 f_week
keep number year month sex location b_year b_month /*
*/edu grad grad_y grad_m grad_age /*
*/job_now job_now_full job_whour job_sy job_sm job_last_survey jleave /*
*/job_find f_month f_week job1_year job1_month /*
*/soldier sol_2stage sol_syear_1 sol_smonth_1 sol_eyear_1 sol_emonth_1 /*
*/sol_syear_2 sol_smonth_2 sol_eyear_2 sol_emonth_2 survey survey_plan 

*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4 //4初(國)中
replace eduy=12 if edu==5|edu==6|edu==7|edu==8 //5高中普通科、6高中職業科、7高職普通科、8高職職業科
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值

*畢業年 -10跳答或不適用 -8拒答 -6不知道 -11不合理值
replace grad_y=9999 if grad_y<0
*畢業年齡 
replace grad_age=9999 if grad_age<0
*第一次正式工作年月
replace job1_year=9999 if job1_year<0
replace job1_month=9999 if job1_month<0
*目前是否有工作 1有 2,3無酬家屬工作 4無 -> 1有 2無酬家屬工作 3無
replace job_now=0 if job_now<6
replace job_now=2 if job_now==3
replace job_now=3 if job_now==4
*現在工作每週工時 -10跳答或不適用 -8拒答 -6不知道 -11不合理值
replace job_whour=9999 if job_whour<0
*現在工作幾年幾月入職
replace job_sy=9999 if job_sy<0
replace job_sm=9999 if job_sm<0
*是否自願離開原來的工作
replace jleave=0 if jleave==-10
replace jleave=9 if jleave==-9
replace jleave=8 if jleave==-8
replace jleave=6 if jleave==-6
replace jleave=3 if job1_year==0
replace job1_year=0 if job1_year==-10
*找工作月數/週數 -10跳答或不適用 -8拒答 -6不知道 -11不合理值
replace f_month=9999 if f_month<0
replace f_week=9999 if f_week<0
*sol_2stage 1兩階段 2一次完成
*入退伍年月
replace sol_syear_1=0 if sol_syear_1<0
replace sol_smonth_1=0 if sol_smonth_1<0
replace sol_eyear_1=0 if sol_eyear_1<0
replace sol_emonth_1=0 if sol_emonth_1<0

replace sol_syear_2=0 if sol_syear_2<0
replace sol_smonth_2=0 if sol_smonth_2<0
replace sol_eyear_2=0 if sol_eyear_2<0
replace sol_emonth_2=0 if sol_emonth_2<0

save "D:\家庭動態調查\主樣本追蹤\data\psfd_RR2022.dta",replace

////////////////////////////////////////////////////////////////////////
*子女樣本ci
use "D:\家庭動態調查\子女樣本\原始檔\ci2000.dta",clear
gen survey="ci"
gen survey_plan="ci2000"
rename x04 number
gen year=2000
rename x05z1 month 
rename x08 location
rename a01 sex
rename a02 b_year
rename b01 edu
rename b13 jun_grady //國中畢業年
rename b20c2 sen_grady
rename b39c2 coll_grady
rename j07a soldier
rename j07b1 sol_syear
rename j07b2 sol_eyear
rename c11a nowj_1yes //第一份正職是否為目前工作 1是 2否 3從未工作過
rename c08z1 nowj_t //這份工作做多久
rename c08z2 nowj_y //做幾年 (已滿1年)
rename c08z3 nowj_m //(又)做幾個月
rename c06 job_whour //每週工時
rename c11b job1_year
rename c02 job_now
rename c10z1 job_find
rename c10z2 f_month
rename c10z3 f_week
keep number year month location sex b_year /*
*/edu jun_grady sen_grady coll_grady /*
*/nowj_1yes nowj_t nowj_y nowj_m job_whour job1_year job_now job_find f_month f_week /*
*/soldier sol_syear sol_eyear survey survey_plan 
*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4 //4初(國)中
replace eduy=12 if edu==6|edu==7|edu==8 //6高中普通科、7高中職業科、8高職
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值

*畢業年 0跳答或不適用 96不知道 98拒答 99缺漏值
replace jun_grady=9999 if jun_grady==96|jun_grady==98|jun_grady==99
replace sen_grady=9999 if sen_grady==96|sen_grady==98|sen_grady==99
replace coll_grady=9999 if coll_grady==96|coll_grady==99
gen grad_y=9999
replace grad_y=coll_grady if coll_grady!=0&coll_grady!=9999&grad_y==9999
replace grad_y=sen_grady if sen_grady!=0&sen_grady!=9999&grad_y==9999
replace grad_y=jun_grady if jun_grady!=0&jun_grady!=9999&grad_y==9999

*第一次正式工作年 0跳答或不適用 96不知道 99缺漏值
replace job1_year=9999 if job1_year==96|job1_year==99
*目前是否有工作 1有 2無->3無
replace job_now=3 if job_now==2
*現在工作每週工時 95超過上限值
replace job_whour=9999 if job_whour==991|job_whour==996|job_whour==997|job_whour==998|job_whour==999
replace job_whour=9990 if job_whour==995
*找工作月數/週數 95超過95個月 96不知道 98拒答 99缺漏值
replace f_month=9999 if f_month==96|f_month==98|f_month==99
replace f_week=9999 if f_week==96|f_week==98|f_week==99 //6不知道 8拒答 9缺漏值
*入退伍年 0跳答或不適用 96不知道 99缺漏值
replace sol_syear=9999 if sol_syear==96|sol_syear==99
replace sol_eyear=9999 if sol_eyear==96|sol_eyear==98|sol_eyear==99
*入退伍月 0跳答或不適用 95服役中 96不知道 98拒答 99遺漏值
*現在工作做幾年幾月
replace nowj_y=9999 if nowj_y==95|nowj_y==99
replace nowj_m=9999 if nowj_m==95|nowj_m==99

save "D:\家庭動態調查\子女樣本\data\psfd_ci2000.dta",replace

use "D:\家庭動態調查\子女樣本\原始檔\ci2002.dta",clear
gen survey="ci"
gen survey_plan="ci2002"
rename x04 number
gen year=2002
rename a01 sex
rename a02 b_year
rename b02 edu
rename b07e2 sen_grady
rename b33z2 coll_grady
rename a05a soldier
rename a05b1 sol_syear
rename a05b2 sol_eyear
rename c02 job_now
rename c09 job_whour //每週工時
rename c03a job_sit //從前年八月到這次訪問,您工作有改變嗎
rename c13a1 job_find
rename c13a2 f_month
rename c13a3 f_week
keep number year sex b_year /*
*/edu sen_grady coll_grady /*
*/job_now job_whour job_sit job_find f_month f_week /*
*/soldier sol_syear sol_eyear survey survey_plan 
*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4 //4初(國)中
replace eduy=12 if edu==6|edu==7|edu==8 //6高中普通科、7高中職業科、8高職
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值

*畢業年 0跳答或不適用 96不知道 98拒答 99缺漏值
replace sen_grady=9999 if sen_grady==96|sen_grady==98|sen_grady==99
replace coll_grady=9999 if coll_grady==96|coll_grady==99
gen grad_y=9999
replace grad_y=coll_grady if coll_grady!=0&coll_grady!=9999&grad_y==9999
replace grad_y=sen_grady if sen_grady!=0&sen_grady!=9999&grad_y==9999
*目前是否有工作 1有 2無->3無
replace job_now=3 if job_now==2
*現在工作每週工時 95超過上限值
replace job_whour=9999 if job_whour==991|job_whour==996|job_whour==997|job_whour==998|job_whour==999
replace job_whour=9990 if job_whour==995
*找工作月數/週數 95超過95個月 96不知道 98拒答 99缺漏值
replace f_month=9999 if f_month==96|f_month==98|f_month==99
replace f_week=9999 if f_week==96|f_week==98|f_week==99 //6不知道 8拒答 9缺漏值
*入退伍年 0跳答或不適用 96不知道 99缺漏值
replace sol_syear=9999 if sol_syear==96|sol_syear==99
replace sol_eyear=9999 if sol_eyear==96|sol_eyear==98|sol_eyear==99

save "D:\家庭動態調查\子女樣本\data\psfd_ci2002.dta",replace

use "D:\家庭動態調查\子女樣本\原始檔\ci2004.dta",clear
gen survey="ci"
gen survey_plan="ci2004"
rename x04 number
rename x05 year
rename g06z01 month 
rename x09 location
rename a01 sex
rename a02 b_year
rename b02 edu
rename b07e02 sen_grady
rename b39z02 coll_grady
rename a05a soldier
rename a05b01 sol_syear
rename a05b02 sol_eyear
rename c02 job_now
rename c09 job_whour //每週工時
rename c03a job_sit //91年一月訪問到現在，工作情況有改變嗎？
rename c04a jleave //1是 0否
rename c13a01 job_find
rename c13a02 f_month
rename c13a03 f_week
keep number year month sex b_year /*
*/edu sen_grady coll_grady /*
*/job_now job_whour job_sit jleave job_find f_month f_week /*
*/soldier sol_syear sol_eyear survey survey_plan 
*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4 //4初(國)中
replace eduy=12 if edu==6|edu==7|edu==8 //6高中普通科、7高中職業科、8高職
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值

*畢業年 0跳答或不適用 96不知道 98拒答 99缺漏值
replace sen_grady=9999 if sen_grady<80|sen_grady==96|sen_grady==98|sen_grady==99
replace coll_grady=9999 if coll_grady<80|coll_grady==96|coll_grady==98|coll_grady==99
gen grad_y=9999
replace grad_y=coll_grady if coll_grady!=0&coll_grady!=9999&grad_y==9999
replace grad_y=sen_grady if sen_grady!=0&sen_grady!=9999&grad_y==9999
*目前是否有工作 1有 2無->3無
replace job_now=3 if job_now==2
*現在工作每週工時 95超過上限值
replace job_whour=9999 if job_whour==991|job_whour==996|job_whour==997|job_whour==998|job_whour==999
replace job_whour=9990 if job_whour==995
*找工作月數/週數 95超過95個月 96不知道 98拒答 99缺漏值
replace f_month=9999 if f_month==96|f_month==98|f_month==99
replace f_week=9999 if f_week==96|f_week==98|f_week==99 //6不知道 8拒答 9缺漏值
*入退伍年 0跳答或不適用 96不知道 99缺漏值
replace sol_syear=9999 if sol_syear==96|sol_syear==99
replace sol_eyear=9999 if sol_eyear==96|sol_eyear==98|sol_eyear==99

save "D:\家庭動態調查\子女樣本\data\psfd_ci2004.dta",replace

use "D:\家庭動態調查\子女樣本\原始檔\ci2006.dta",clear
gen survey="ci"
gen survey_plan="ci2006"
rename z01 number
rename z02 year
rename x04z01 month 
rename a01 sex
rename a02z01 b_year
rename a02z02 b_month
rename b02 edu
rename b07e02 sen_grady
rename b25z02 coll_grady
rename a06a soldier
rename a06c01 sol_syear
rename a06c02 sol_smonth
rename a06c03 sol_eyear
rename a06c04 sol_emonth
rename c02 job_now
rename c09 job_whour //每週工時
rename c03a01 job_change //從去年一月份以來，更換過工作嗎1 相同工作1 其他7
rename c04a jleave
rename c13a01 job_find
rename c13a02 f_month
rename c13a03 f_week
keep number year month sex b_year b_month /*
*/edu sen_grady coll_grady /*
*/job_now job_whour job_change jleave job_find f_month f_week /*
*/soldier sol_syear sol_smonth sol_eyear sol_emonth survey survey_plan 
*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4 //4初(國)中
replace eduy=12 if edu==6|edu==7|edu==8 //6高中普通科、7高中職業科、8高職
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值

*畢業年 0跳答或不適用 96不知道 98拒答 99缺漏值
replace sen_grady=9999 if sen_grady<80|sen_grady==96|sen_grady==98|sen_grady==99
replace coll_grady=9999 if coll_grady<80|coll_grady==96|coll_grady==98|coll_grady==99
gen grad_y=9999
replace grad_y=coll_grady if coll_grady!=0&coll_grady!=9999&grad_y==9999
replace grad_y=sen_grady if sen_grady!=0&sen_grady!=9999&grad_y==9999
*現在工作每週工時 95超過上限值
replace job_whour=9999 if job_whour==991|job_whour==996|job_whour==997|job_whour==998|job_whour==999
replace job_whour=9990 if job_whour==995
*找工作月數/週數 95超過95個月 96不知道 98拒答 99缺漏值
replace f_month=9999 if f_month==96|f_month==98|f_month==99
replace f_week=9999 if f_week==96|f_week==98|f_week==99 //6不知道 8拒答 9缺漏值
*入退伍年 0跳答或不適用 96不知道 99缺漏值
replace sol_syear=9999 if sol_syear==96|sol_syear==99
replace sol_eyear=9999 if sol_eyear==96|sol_eyear==98|sol_eyear==99
*入退伍月 0跳答或不適用 95服役中 96不知道 98拒答 99遺漏值

save "D:\家庭動態調查\子女樣本\data\psfd_ci2006.dta",replace

use "D:\家庭動態調查\子女樣本\原始檔\ci2008.dta",clear
gen survey="ci"
gen survey_plan="ci2008"
rename x01 number
rename x02 year
rename x02z01 month 
rename a01 sex
rename a02z01 b_year
rename a02z02 b_month
rename b02 edu
rename b07f02 sen_grady
rename b25z02 coll_grady
rename a06a soldier
rename a06c01 sol_syear
rename a06c02 sol_smonth
rename a06c03 sol_eyear
rename a06c04 sol_emonth
rename c02 job_now
rename c08 job_whour //每週工時
rename c09z01 nowj_y //做這份工作多久年
rename c09z02 nowj_m
rename c03a01 job_change //從去年一月份 以來，更換過工作嗎1 相同工作1 其他7
rename c04a jleave
rename c13b01 job_find
rename c13b02 f_month
rename c13b03 f_week
keep number year month sex b_year b_month /*
*/edu sen_grady coll_grady /*
*/job_now job_whour nowj_y nowj_m job_change jleave job_find f_month f_week /*
*/soldier sol_syear sol_smonth sol_eyear sol_emonth survey survey_plan 
*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4 //4初(國)中
replace eduy=12 if edu==6|edu==7|edu==8 //6高中普通科、7高中職業科、8高職
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值

*畢業年 0跳答或不適用 996不知道 998拒答 999缺漏值
replace sen_grady=9999 if sen_grady<80|sen_grady==996|sen_grady==999
replace coll_grady=9999 if coll_grady<80|coll_grady==996|coll_grady==998|coll_grady==999
gen grad_y=9999
replace grad_y=coll_grady if coll_grady!=0&coll_grady!=9999&grad_y==9999
replace grad_y=sen_grady if sen_grady!=0&sen_grady!=9999&grad_y==9999

*現在工作做幾年幾月
replace nowj_y=9999 if nowj_y==96|nowj_y==99
replace nowj_m=9999 if nowj_m==96|nowj_m==99
*現在工作每週工時
replace job_whour=9999 if job_whour==991
*找工作月數/週數 95超過95個月 96不知道 98拒答 99缺漏值
replace f_month=9999 if f_month==96|f_month==98|f_month==99
replace f_week=9999 if f_week==96|f_week==98|f_week==99 //6不知道 8拒答 9缺漏值
*入退伍年 0跳答或不適用 996不知道 999缺漏值
replace sol_syear=9999 if sol_syear==996|sol_syear==999
replace sol_eyear=9999 if sol_eyear==996|sol_eyear==998|sol_eyear==999
*入退伍月 0跳答或不適用 95服役中 96不知道 98拒答 99遺漏值

save "D:\家庭動態調查\子女樣本\data\psfd_ci2008.dta",replace

use "D:\家庭動態調查\子女樣本\原始檔\ci2010.dta",clear
gen survey="ci"
gen survey_plan="ci2010"
rename x01 number
gen year=2010
rename x03z01 month 
rename a01 sex
rename a02z01 b_year
rename a02z02 b_month
rename b02 edu
rename b07f02 sen_grady
rename b25z02 coll_grady
rename a06a soldier
rename a06c01 sol_syear
rename a06c02 sol_smonth
rename a06c03 sol_eyear
rename a06c04 sol_emonth
rename c02 job_now
rename c08 job_whour //每週工時
rename c09z01 nowj_y
rename c09z02 nowj_m
rename c03a01 job_change //從去年一月份 以來，更換過工作嗎1 相同工作1 其他7
rename c04a jleave
rename c13a01 job_find
rename c13a02 f_month
rename c13a03 f_week
keep number year month sex b_year b_month /*
*/edu sen_grady coll_grady /*
*/job_now job_whour nowj_y nowj_m job_change jleave job_find f_month f_week /*
*/soldier sol_syear sol_smonth sol_eyear sol_emonth survey survey_plan 
*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4 //4初(國)中
replace eduy=12 if edu==6|edu==7|edu==8 //6高中普通科、7高中職業科、8高職
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值

*畢業年 0跳答或不適用 996不知道 998拒答 999缺漏值
replace sen_grady=9999 if sen_grady<80|sen_grady==996|sen_grady==999
replace coll_grady=9999 if coll_grady<80|coll_grady==996|coll_grady==998|coll_grady==999
gen grad_y=9999
replace grad_y=coll_grady if coll_grady!=0&coll_grady!=9999&grad_y==9999
replace grad_y=sen_grady if sen_grady!=0&sen_grady!=9999&grad_y==9999
*現在工作做幾年幾月
replace nowj_y=9999 if nowj_y==96|nowj_y==99
replace nowj_m=9999 if nowj_m==96|nowj_m==99
*現在工作每週工時
replace job_whour=9999 if job_whour==991|job_whour==996
*找工作月數/週數 95超過95個月 96不知道 98拒答 99缺漏值
replace f_month=9999 if f_month==96|f_month==98|f_month==99
replace f_week=9999 if f_week==96|f_week==98|f_week==99 //6不知道 8拒答 9缺漏值
*入退伍年 0跳答或不適用 996不知道 999缺漏值
replace sol_syear=9999 if sol_syear==996|sol_syear==999
replace sol_eyear=9999 if sol_eyear==996|sol_eyear==998|sol_eyear==999
*入退伍月 0跳答或不適用 95服役中 96不知道 98拒答 99遺漏值

save "D:\家庭動態調查\子女樣本\data\psfd_ci2010.dta",replace

use "D:\家庭動態調查\子女樣本\原始檔\ci2012.dta",clear
gen survey="ci"
gen survey_plan="ci2012"
rename x01 number
gen year=2012
rename x03z01 month 
rename a01 sex
rename a02z01 b_year
rename a02z02 b_month
rename b02 edu
rename b07f02 sen_grady
rename b25z02 coll_grady
rename a06a soldier
rename a06c01 sol_syear
rename a06c02 sol_smonth
rename a06c03 sol_eyear
rename a06c04 sol_emonth
rename c02 job_now
rename c08 job_whour //每週工時
rename c09z01 nowj_y //已做多久
rename c09z02 nowj_m
rename c03a01 job_change //從去年一月份 以來，更換過工作嗎1 相同工作1 其他7
rename c04a jleave
rename c13a01 job_find
rename c13a02 f_month
rename c13a03 f_week
keep number year month sex b_year b_month /*
*/edu sen_grady coll_grady /*
*/job_now job_whour nowj_y nowj_m job_change jleave job_find f_month f_week /*
*/soldier sol_syear sol_smonth sol_eyear sol_emonth survey survey_plan 
*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4 //4初(國)中
replace eduy=12 if edu==6|edu==7|edu==8 //6高中普通科、7高中職業科、8高職
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值

*畢業年 0跳答或不適用 996不知道 998拒答 999缺漏值
replace sen_grady=9999 if sen_grady<80|sen_grady==996|sen_grady==999
replace coll_grady=9999 if coll_grady<80|coll_grady==996|coll_grady==998|coll_grady==999
gen grad_y=9999
replace grad_y=coll_grady if coll_grady!=0&coll_grady!=9999&grad_y==9999
replace grad_y=sen_grady if sen_grady!=0&sen_grady!=9999&grad_y==9999
*現在工作做幾年幾月
replace nowj_y=9999 if nowj_y==96|nowj_y==98|nowj_m==99
replace nowj_m=9999 if nowj_m==96|nowj_m==98|nowj_m==99
*現在工作每週工時
replace job_whour=9999 if job_whour==991|job_whour==996|job_whour==998
*找工作月數/週數 95超過95個月 96不知道 98拒答 99缺漏值
replace f_month=9999 if f_month==96|f_month==98|f_month==99
replace f_week=9999 if f_week==6|f_week==98|f_week==99 //6不知道 8拒答 9缺漏值
*入退伍年 0跳答或不適用 996不知道 999缺漏值
replace sol_syear=9999 if sol_syear==998|sol_syear==999
replace sol_eyear=9999 if sol_eyear==998|sol_eyear==999
replace sol_eyear=9990 if sol_eyear==996
*入退伍月 0跳答或不適用 95服役中 96不知道 98拒答 99遺漏值
replace sol_emonth=95 if sol_emonth==96

save "D:\家庭動態調查\子女樣本\data\psfd_ci2012.dta",replace

use "D:\家庭動態調查\子女樣本\原始檔\ci2014.dta",clear
gen survey="ci"
gen survey_plan="ci2014"
rename x01 number
gen year=2014
rename x03z01 month 
rename a01 sex
rename a02z01 b_year
rename a02z02 b_month
rename b02 edu
rename b07g02 sen_grady
rename b25z02 coll_grady
rename a06a soldier
rename a06c01 sol_syear
rename a06c02 sol_smonth
rename a06c03 sol_eyear
rename a06c04 sol_emonth
rename c02 job_now
rename c06b job_whour //每週工時
rename c07a01 job_sy //何時開始
rename c07a02 job_sm 
rename c08c jleave
rename c12a01 job_find
rename c12a02 f_month
rename c12a03 f_week
keep number year month sex b_year b_month /*
*/edu sen_grady coll_grady /*
*/job_now job_whour job_sy job_sm jleave job_find f_month f_week /*
*/soldier sol_syear sol_smonth sol_eyear sol_emonth survey survey_plan 
*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4 //4初(國)中
replace eduy=12 if edu==5|edu==6|edu==7|edu==8 //5高中普通科、6高中職業科、7高職普通科、8高職職業科
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值

*畢業年 0跳答或不適用 996不知道 998拒答 999缺漏值
replace sen_grady=9999 if sen_grady<80|sen_grady==996|sen_grady==999
replace coll_grady=9999 if coll_grady<80|coll_grady==996|coll_grady==998|coll_grady==999
gen grad_y=9999
replace grad_y=coll_grady if coll_grady!=0&coll_grady!=9999&grad_y==9999
replace grad_y=sen_grady if sen_grady!=0&sen_grady!=9999&grad_y==9999
*現在工作幾年幾月入職
replace job_sy=9999 if job_sy==996|job_sy==998|job_sy==999
replace job_sm=9999 if job_sm==96|job_sm==98|job_sm==99
*現在工作每週工時
replace job_whour=9999 if job_whour==991|job_whour==996|job_whour==998
*找工作月數/週數 95超過95個月 96不知道 98拒答 99缺漏值
replace f_month=9999 if f_month==96|f_month==98|f_month==99
replace f_week=9999 if f_week==6|f_week==98|f_week==99 //6不知道 8拒答 9缺漏值
*入退伍年 0跳答或不適用 996不知道 999缺漏值
replace sol_syear=9999 if sol_syear==996|sol_syear==998|sol_syear==999
replace sol_eyear=9999 if sol_eyear==996|sol_eyear==998|sol_eyear==999
replace sol_eyear=9990 if sol_eyear==995
*入退伍月 0跳答或不適用 95服役中 96不知道 98拒答 99遺漏值

save "D:\家庭動態調查\子女樣本\data\psfd_ci2014.dta",replace

use "D:\家庭動態調查\子女樣本\原始檔\ci2016.dta",clear
gen survey="ci"
gen survey_plan="ci2016"
rename x01 number
gen year=2016
rename x03z01 month 
rename a01 sex
rename a02a01 b_year
rename a02a02 b_month
rename b02 edu
rename b07f02 sen_grady
rename b29z02 coll_grady
rename a06a soldier
rename a06c01 sol_syear
rename a06c02 sol_smonth
rename a06c03 sol_eyear
rename a06c04 sol_emonth
rename c02z01 job_now
rename c06b01 job_whour //每週工時
rename c07a job_last_survey
rename c07b07 job_lastyear
rename c08a01 job_sy //何時開始
rename c08a02 job_sm 
rename c08f jleave
rename c12a01 job_find
rename c12a02 f_month
rename c12a03 f_week
keep number year month sex b_year b_month /*
*/edu sen_grady coll_grady /*
*/job_now job_whour job_last_survey job_lastyear job_sy job_sm jleave job_find f_month f_week /*
*/soldier sol_syear sol_smonth sol_eyear sol_emonth survey survey_plan 
*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4 //4初(國)中
replace eduy=12 if edu==5|edu==6|edu==7|edu==8 //5高中普通科、6高中職業科、7高職普通科、8高職職業科
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值

*畢業年 0跳答或不適用 996不知道 998拒答 999缺漏值
replace sen_grady=9999 if sen_grady<80|sen_grady==996|sen_grady==999
replace coll_grady=9999 if coll_grady<80|coll_grady==996|coll_grady==998|coll_grady==999
gen grad_y=9999
replace grad_y=coll_grady if coll_grady!=0&coll_grady!=9999&grad_y==9999
replace grad_y=sen_grady if sen_grady!=0&sen_grady!=9999&grad_y==9999
*現在工作幾年幾月入職
replace job_sy=9999 if job_sy==996|job_sy==998|job_sy==999
replace job_sm=9999 if job_sm==96|job_sm==98|job_sm==99
*現在工作每週工時
replace job_whour=9999 if job_whour==991|job_whour==996|job_whour==998
*找工作月數/週數 95超過95個月 96不知道 98拒答 99缺漏值
replace f_month=9999 if f_month==96|f_month==98|f_month==99
replace f_week=9999 if f_week==6|f_week==98|f_week==9 //6不知道 8拒答 9缺漏值
*入退伍年 0跳答或不適用 996不知道 999缺漏值
replace sol_syear=9999 if sol_syear==996|sol_syear==998|sol_syear==999
replace sol_eyear=9999 if sol_eyear==996|sol_eyear==998|sol_eyear==999
replace sol_eyear=9990 if sol_eyear==995
*入退伍月 0跳答或不適用 95服役中 96不知道 98拒答 99遺漏值

save "D:\家庭動態調查\子女樣本\data\psfd_ci2016.dta",replace

use "D:\家庭動態調查\子女樣本\原始檔\ci2018.dta",clear
gen survey="ci"
gen survey_plan="ci2018"
rename x01 number
gen year=2018
rename x03z01 month 
rename a01 sex
rename a02a01 b_year
rename a02a02 b_month
rename b02a edu
rename b07f02 sen_grady
rename b29z02 coll_grady
rename a06a soldier
rename a06c01 sol_2stage //是否兩階段完成兵役
rename a06c06 sol_syear_2 //兩階段入伍年
rename a06c07 sol_smonth_2
rename a06c08 sol_eyear_2
rename a06c09 sol_emonth_2
rename a06c10 sol_syear_1 //一次完成入伍年
rename a06c11 sol_smonth_1
rename a06c12 sol_eyear_1
rename a06c13 sol_emonth_1
rename c02 job_now
rename c06b job_whour //每週工時
rename c07a job_last_survey
rename c08a01 job_sy //何時開始
rename c08a02 job_sm 
rename c08f jleave //1是 2否 3從未工作過 6不知道 9遺漏值
rename c12a01 job_find
rename c12a02 f_month
rename c12a03 f_week
keep number year month sex b_year b_month /*
*/edu sen_grady coll_grady /*
*/job_now job_whour job_last_survey job_sy job_sm jleave job_find f_month f_week /*
*/soldier sol_2stage sol_syear_1 sol_smonth_1 sol_eyear_1 sol_emonth_1 sol_syear_2 sol_smonth_2 sol_eyear_2 sol_emonth_2 survey survey_plan 
*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4 //4初(國)中
replace eduy=12 if edu==5|edu==6|edu==7|edu==8 //5高中普通科、6高中職業科、7高職普通科、8高職職業科
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值

*畢業年 0跳答或不適用 996不知道 998拒答 999缺漏值
replace sen_grady=9999 if sen_grady<80|sen_grady==996|sen_grady==999
replace coll_grady=9999 if coll_grady<80|coll_grady==996|coll_grady==998|coll_grady==999
gen grad_y=9999
replace grad_y=coll_grady if coll_grady!=0&coll_grady!=9999&grad_y==9999
replace grad_y=sen_grady if sen_grady!=0&sen_grady!=9999&grad_y==9999
*現在工作幾年幾月入職
replace job_sy=9999 if job_sy==996|job_sy==998|job_sy==999
replace job_sm=9999 if job_sm==96|job_sm==98|job_sm==99
*現在工作每週工時
replace job_whour=9999 if job_whour==991|job_whour==996|job_whour==998
*找工作月數/週數 95超過95個月 96不知道 98拒答 99缺漏值
replace f_month=9999 if f_month==96|f_month==98|f_month==99
replace f_week=9999 if f_week==6|f_week==8|f_week==9 //6不知道 8拒答 9缺漏值
*sol_2stage 1兩階段 2一次完成
*入退伍年 0跳答或不適用 996不知道 995服役中/第二階段尚未入營 999遺漏值
replace sol_syear_1=9999 if sol_syear_1==996
replace sol_syear_2=9999 if sol_syear_2==999
replace sol_syear_2=9990 if sol_syear_2==995

replace sol_eyear_1=9999 if sol_eyear_1==996|sol_eyear_1==999
replace sol_eyear_1=9990 if sol_eyear_1==995
replace sol_eyear_2=9999 if sol_eyear_2==999
replace sol_eyear_2=9990 if sol_eyear_2==995
*9990 服役中
*入退伍月 0跳答或不適用 95服役中/第二階段尚未入營 96不知道 99遺漏值

save "D:\家庭動態調查\子女樣本\data\psfd_ci2018.dta",replace

use "D:\家庭動態調查\子女樣本\原始檔\ci2020.dta",clear
gen survey="ci"
gen survey_plan="ci2020"
rename x01 number
gen year=2020
rename x03z01 month 
rename a01 sex
rename a02a01 b_year
rename a02a02 b_month
rename b02a edu
rename b07f02 sen_grady
rename b29z02 coll_grady
rename w02a soldier
rename a06c01 sol_2stage //是否兩階段完成兵役
rename a06c06 sol_syear_2 //兩階段入伍年
rename a06c07 sol_smonth_2
rename a06c08 sol_eyear_2
rename a06c09 sol_emonth_2
rename a06c10 sol_syear_1 //一次完成入伍年
rename a06c11 sol_smonth_1
rename a06c12 sol_eyear_1
rename a06c13 sol_emonth_1
rename w03 job_now
rename w06g job_whour //每週工時
rename w09z07 job_last_survey
rename w10z01 job_sy //何時開始
rename w10z02 job_sm 
rename w13a jleave //1是 2否 3從未工作過 6不知道 8拒答 9遺漏值
rename w18a01 job_find
rename w18a02 f_month
rename w18a03 f_week
keep number year month sex b_year b_month /*
*/edu sen_grady coll_grady /*
*/job_now job_whour job_last_survey job_sy job_sm jleave job_find f_month f_week /*
*/soldier sol_2stage sol_syear_1 sol_smonth_1 sol_eyear_1 sol_emonth_1 sol_syear_2 sol_smonth_2 sol_eyear_2 sol_emonth_2 survey survey_plan 
*教育年數
gen eduy=0
replace eduy=6 if edu==3 //3小學
replace eduy=9 if edu==4 //4初(國)中
replace eduy=12 if edu==5|edu==6|edu==7|edu==8 //5高中普通科、6高中職業科、7高職普通科、8高職職業科
replace eduy=14 if edu==9|edu==10 //9五專、10二專
replace eduy=15 if edu==11 //11三專
replace eduy=16 if edu==12|edu==13 //12技術學院、13大學或獨立學院
replace eduy=18 if edu==14 //14碩班
replace eduy=20 if edu==15 //15博班
//96不知道 97其他 98拒答 99缺漏值

*畢業年 0跳答或不適用 996不知道 998拒答 999缺漏值
replace sen_grady=9999 if sen_grady<80|sen_grady==996|sen_grady==999
replace coll_grady=9999 if coll_grady<80|coll_grady==996|coll_grady==998|coll_grady==999
gen grad_y=9999
replace grad_y=coll_grady if coll_grady!=0&coll_grady!=9999&grad_y==9999
replace grad_y=sen_grady if sen_grady!=0&sen_grady!=9999&grad_y==9999
*現在工作幾年幾月入職
replace job_sy=9999 if job_sy==996|job_sy==998|job_sy==999
replace job_sm=9999 if job_sm==96|job_sm==98|job_sm==99
*現在工作每週工時
replace job_whour=9999 if job_whour==991|job_whour==996|job_whour==998
*找工作月數/週數 95超過95個月 96不知道 98拒答 99缺漏值
replace f_month=9999 if f_month==96|f_month==98|f_month==99
replace f_week=9999 if f_week==6|f_week==8|f_week==9 //6不知道 8拒答 9缺漏值
*sol_2stage 1兩階段 2一次完成
*入退伍年 0跳答或不適用 996不知道 995服役中/第二階段尚未入營 999遺漏值
replace sol_syear_1=9999 if sol_syear_1==996|sol_syear_1==999
replace sol_eyear_1=9999 if sol_eyear_1==996|sol_eyear_1==999
replace sol_eyear_1=9990 if sol_eyear_1==995

replace sol_syear_2=9999 if sol_syear_2==996|sol_syear_2==999
replace sol_syear_2=9990 if sol_syear_2==995
replace sol_eyear_2=9999 if sol_eyear_2==999|sol_eyear_2==996
replace sol_eyear_2=9990 if sol_eyear_2==995
*9990 服役中
*入退伍月 0跳答或不適用 95服役中/第二階段尚未入營 96不知道 99遺漏值

save "D:\家庭動態調查\子女樣本\data\psfd_ci2020.dta",replace


//////////////////////////////////////////////////////////////
clear
*主樣本
foreach i in 2004 2005 2007 2009 2011 2014 2016 2018 2020{
append using "D:\家庭動態調查\主樣本\data\psfd_rci`i'.dta", force

}
foreach i in 1999 2000 2003 2009 2016{
append using "D:\家庭動態調查\主樣本\data\psfd_ri`i'.dta", force

}
*子女樣本
foreach i in 2000 2002 2004 2006 2008 2010 2012 2014 2016 2018 2020{
append using "D:\家庭動態調查\子女樣本\data\psfd_ci`i'.dta", force

}
*追蹤樣本
foreach i in 2000 2001_2 2001_3 2002 2003 2004 2005 2006 2007 2008 /*
*/2009 2010 2011 2012 2014 2016 2018 2020 2022{
append using "D:\家庭動態調查\主樣本追蹤\data\psfd_RR`i'.dta", force

}

g number_str=string(number)
g num_len=length(number_str)
replace number_str ="0"+number_str if num_len ==6
replace number_str ="00"+number_str if num_len ==5
ren number number_m
ren number_str number
order number survey_plan year job1 job1_year grad_y soldier sol_eyear sol_emonth sol_2stage sol_eyear_1 sol_emonth_1 sol_eyear_2 sol_emonth_2 
sort number year
replace grad_y=9999 if grad_y>=996
label define grad_y 9999 "9999 拒答、不知道"
label value grad_y grad_y
///
label define job_now 0 "0 跳答或不適用" 1 "1 有" 2 "2 有(無酬家屬工作)" 3"3 無"
label value job_now job_now
label define jleave 0 "0 跳答" 1 "1 是" 2 "2 否" 3 "3 過去從未工作過" 6 "6 不知道" 8 "8 拒答" 9 "9 遺漏值"
label value jleave jleave
label define soldier 0 "0 跳答或不適用" 1 "1 有" 2 "2 無，尚未當兵" 3 "3 無，免役" 6 "6 不知道"
label value soldier soldier
label define job1_year 0 "0 跳答或不適用" 9999 "9999 拒答、不知道"
label value job1_year job1_year
label define f_month 95 "95 超過95個月" 9990 "9990 超過上限值" 9991 "9991 超過10年" 9999 "9999 不知道"
label value f_month f_month
label define f_week 9990 "9990 超過上限值" 9999 "9999 不知道"
label value f_week f_week
///
label define sol_syear 0 "0 跳答或不適用" 9999 "9999 拒答、不知道"
label value sol_syear sol_syear
label define sol_eyear 0 "0 跳答或不適用" 9990 "9990 服役中" 9999 "9999 拒答、不知道"
label value sol_eyear sol_eyear
label define sol_emonth 0 "0 跳答或不適用" 95 "95 服役中" 96 "96 不知道" 98 "98 拒答" 99 "99 遺漏值"
label value sol_emonth sol_emonth
label define sol_smonth 0 "0 跳答或不適用" 96 "96 不知道" 98 "98 拒答" 99 "99 遺漏值"
label value sol_smonth sol_smonth

save "D:\家庭動態調查\分析\analysis_data.dta",replace

//////////////////////////////////////////////////////////////
/*if `i'==2020{
replace eduy=12 if edu==5 //初職
}*/
*每週工時 
tab year
tab sex
tab b_year
tab edu
tab grad_y
*tab grad
*tab elem_year
*tab jun_year
tab job_now
tab job_whour
*tab job_timey
*tab job_timem
*tab job_change
*tab job_thisyear
*tab job_lastyear
tab job_last_survey
*tab job1_year
tab jleave //是否自願離開原有工作 1是 2否 3過去從來沒有工作過
*tab job1
tab job_find
tab f_month //RR2002
tab f_week
tab jun_grady
tab sen_grady
tab coll_grady
tab soldier
tab sol_syear
tab sol_eyear
tab sol_smonth
tab sol_emonth
tab job_sy
tab job_sm
*tab nowj_1yes
*tab nowj_t
*tab nowj_y
*tab nowj_m



tab sol_2stage
tab sol_syear_2
tab sol_smonth_2
tab sol_eyear_2
tab sol_emonth_2
tab sol_syear_1
tab sol_smonth_1
tab sol_eyear_1
tab sol_emonth_1


use "D:\家庭動態調查\分析\analysis_data.dta",clear

//找工作時間

gen year_roc=year-1911
gen time=year_roc+(month-1)/12
replace time=year_roc if month==.
*********************************************************性別、出生日期處理
gen sex_skip=sex==.
gsort number sex_skip -year sex
by number: replace sex=sex[1]
drop sex_skip

replace b_year=. if b_year==9999
gen b_skip=b_year==.
gsort number b_skip -year b_year
by number: replace b_year=b_year[1]
drop b_skip

*********************************************************當兵時間處理
*一階當兵處理
*ri2000 有回答退伍年齡 但沒有回答退伍時間
replace sol_eyear=b_year+sol_eage if survey_plan =="ri2000"&sol_eage!=0&sol_eage!=9999
replace soldier=sol_eage!=0 if survey_plan =="ri2000"

gen soldier_yes=soldier==1
gen sol_yskip=sol_eyear>=9990|sol_eyear==0|sol_eyear==.
gen sol_mskip=sol_emonth>=95|sol_emonth==0|sol_emonth==.
replace sol_eyear=0 if sol_eyear==.
replace sol_emonth=0 if sol_emonth==.
order number survey_plan year job1 job1_year grad_y soldier_yes sol_eyear sol_emonth sol_2stage sol_eyear_1 sol_emonth_1 sol_eyear_2 sol_emonth_2 sol_eage sol_ty sol_tm

gsort number -soldier_yes sol_yskip -year -sol_eyear 
by number: replace sol_eyear=sol_eyear[1] if sol_eyear[1]<9990

gsort number -soldier_yes sol_mskip -year -sol_emonth 
by number: replace sol_emonth=sol_emonth[1] if sol_emonth[1]<=12
foreach i in soldier_yes sol_yskip sol_mskip{
replace `i'=.
}
*二階之1次完成當兵處理
replace soldier_yes=sol_2stage==2
replace sol_yskip=sol_eyear_1>=9990|sol_eyear_1==0|sol_eyear_1==.
replace sol_mskip=sol_emonth_1>=95|sol_emonth_1==0|sol_emonth_1==.
replace sol_eyear_1=0 if sol_eyear_1==.
replace sol_emonth_1=0 if sol_emonth_1==.
order number survey_plan year job1 job1_year grad_y sol_2stage soldier_yes sol_eyear_1 sol_emonth_1 

gsort number -soldier_yes sol_yskip -year -sol_eyear_1 
by number: replace sol_eyear_1=sol_eyear_1[1] if sol_eyear_1[1]<9990

gsort number -soldier_yes sol_mskip -year -sol_emonth_1
by number: replace sol_emonth_1=sol_emonth_1[1] if sol_emonth_1[1]<=12
foreach i in soldier_yes sol_yskip sol_mskip{
replace `i'=.
}

*二階之2次完成當兵處理
replace soldier_yes=sol_2stage==1
replace sol_yskip=sol_eyear_2>=9990|sol_eyear_2==0|sol_eyear_2==.
replace sol_mskip=sol_emonth_2>=95|sol_emonth_2==0|sol_emonth_2==.
replace sol_eyear_2=0 if sol_eyear_2==.
replace sol_emonth_2=0 if sol_emonth_2==.
order number survey_plan year job1 job1_year grad_y sol_2stage soldier_yes sol_eyear_2 sol_emonth_2 

gsort number -soldier_yes sol_yskip -year -sol_eyear_2 
by number: replace sol_eyear_2=sol_eyear_2[1] if sol_eyear_2[1]<9990

gsort number -soldier_yes sol_mskip -year -sol_emonth_2
by number: replace sol_emonth_2=sol_emonth_2[1] if sol_emonth_2[1]<=12

*********************************************************當兵時間處理_變數整合
//把不同問卷的退伍時間整合
gen sol_ey=.
replace sol_ey=sol_eyear if sol_eyear!=0&sol_eyear<9990
replace sol_ey=sol_eyear_1 if sol_eyear_1!=0&sol_eyear_1<9990
replace sol_ey=sol_eyear_2 if sol_eyear_2!=0&sol_eyear_2<9990

gen sol_em=0
replace sol_em=sol_emonth if sol_emonth!=0&sol_emonth<95
replace sol_em=sol_emonth_1 if sol_emonth_1!=0&sol_emonth_1<95
replace sol_em=sol_emonth_2 if sol_emonth_2!=0&sol_emonth_2<95

*********************************************************第一份正式工作時間處理
order number survey_plan year job1 job1_year grad_y
*RR2003 job1_age
replace job1_year=job1_age+b_year if survey_plan=="RR2003"
replace job1_year=0 if job1_age==0&survey_plan=="RR2003"
replace job1_year=. if (job1_age==9999|b_year==9999)&survey_plan=="RR2003"

*ci2000 nowj_1yes nowj_t nowj_y nowj_m //1尚未開始工作 2未滿1年 3已滿1年
replace nowj_m=0 if nowj_m==9999
replace nowj_m=nowj_y if nowj_t==2&nowj_y>0&nowj_m==0
replace nowj_y=0 if nowj_t==2
gen jtime=nowj_y+(nowj_m)/12 if nowj_y!=9999&nowj_m!=9999
gen job1_time=time-jtime if nowj_1yes==1&jtime>0&nowj_y!=9999
replace job1_year=job1_time if survey_plan=="ci2000"

**************************
gen job_yskip=job1_year==9999|job1_year==0|job1_year==.
gen job_mskip=job1_month==9999|job1_month==.|job1_month==0
gen job_noskip=job_yskip==0&job_mskip==0

*RR2022 job1_month
replace job1_year=job1_year+(job1_month-1)/12 if job_noskip==1&survey_plan=="RR2022"
replace job1_year=job1_year if job_yskip==0&job_mskip==1&survey_plan=="RR2022"


gsort number -job_noskip job_yskip job_mskip -year job1_year 
by number: replace job1_year=job1_year[1] if job1_year[1]!=9999

*RR2018 job1

*********************************************************教育程度&畢業時間處理
gen edu_skip=.
replace edu_skip=edu>=16|edu==.
order number survey_plan edu_skip year eduy
gsort number edu_skip -year eduy
by number: replace eduy=eduy[1]

gen grad_yskip=.
replace grad_yskip=grad_y==9999
gen grad_mskip=grad_m<0|grad_m==.
gen grad_noskip=grad_yskip==0&grad_mskip==0

*RR2022
replace grad_m=6 if grad_m<0|grad_m==.
replace grad_y=grad_y+(grad_m-1)/12 if grad_y!=9999&grad_m!=.
//
*

order number grad_yskip year grad_y
gsort number -grad_noskip grad_yskip grad_mskip -year grad_y
by number: replace grad_y=grad_y[1] if grad_y[1]!=9999


*********************************************************初次失業期間計算
//畢業(退伍)後，從來沒有工作過且現在也沒有工作的人找工作的時間
//grad_y(sol_ey+sol_em)，(job1_year==0|jleave==6)&job_now==3&job_find==1，f_month+f_week
*ci2018 ci2020 jleave==f_month+f_week
*ci2000 nowj_1yes //1是 2否 3從未工作過
*RR2004 nojob_time //1不到一年 2超過一年 3從未工作過
replace f_week=68 if f_week==9990
replace f_week=0 if f_week==9999|f_week==.
replace f_month=0 if f_month==.
replace f_month=95 if f_month==9990
replace f_month=10*12 if f_month==9991
gen seek_time=(f_month+f_week/4)/12 if job1_year==0&job_find==1&f_month!=9999
*gen seek_time=(f_month+f_week/4)/12 if (jleave==3|nowj_1yes==3|nojob_time==3)&job_find==1&f_month!=9999
*replace seek_time=f_month+f_week if nojob_time==3&job_find==1&f_month!=0&f_week!=0 //都是缺漏值

gen sol_etime=sol_ey+(sol_em-1)/12 if sol_emonth<95&sex==1&sol_em!=0
replace sol_etime=sol_ey if sex==1&sol_em==0

*********************************************************初次尋職期間(年)計算
//女性
preserve
keep if sex==2
gen find_time_f=job1_year-grad_y if int(job1_year)>int(grad_y) //工作年份>畢業年份、(無工作月、無畢業月)or(有工作月、無畢業月)or(有工作月、有畢業月)->相減
replace find_time_f=job1_year-grad_y+1/12 if int(job1_year)>int(grad_y)&job_mskip==1&grad_m!=. //工作年份>畢業年份、無工作月、有畢業月->相減+1/12
replace find_time_f=1 if int(job1_year)==int(grad_y)&grad_m==.&job_mskip==1 //工作與畢業同年、無工作月份、無畢業月份->1/12
replace find_time_f=1-grad_m/12+1/12 if int(job1_year)==int(grad_y)&grad_m!=. //工作與畢業同年、無工作月份、有畢業月份->1-畢業月份/12+1/12
replace find_time_f=job1_year-grad_y+1/12 if int(job1_year)==int(grad_y)&job_mskip==0&grad_m!=. //工作與畢業同年、有工作月份、有畢業月份->相減+1/12
replace find_time_f=job1_year-grad_y if int(job1_year)==int(grad_y)&job_mskip==0&grad_m==. //工作與畢業同年、有工作月份、無畢業月份->相減
replace find_time_f=1 if int(job1_year)==int(grad_y)&job_mskip==0&grad_m!=.&find_time_f<=0 //工作與畢業同年、有工作月份、有畢業月份、畢業實際月份比推估早->1/12
replace find_time_f=. if job1_year==0|job1_year==9999|grad_y==9999

gen find_skip=.
replace find_skip=job1_year==0|job1_year==9999|grad_y==9999
order number survey_plan find_skip year find_time_f
gsort number find_skip -year find_time_f
by number: replace find_time_f=find_time_f[1] if find_time_f[1]!=9999

keep number sex find_time_f
duplicates drop
tempfile find_time_f
save `find_time_f.dta'
restore
merge m:1 number sex using `find_time_f.dta'
drop _merge

//男性
preserve
keep if sex==1
replace sol_etime=0 if sol_etime<0
drop if sol_etime>9989|job1_year==9999
gen find_time_m=.
replace find_time_m=job1_year-sol_etime if int(job1_year)>sol_ey //工作年份>退伍年份、(無工作月、無退伍月)or(有工作月、無退伍月)or(有工作月、有退伍月)->相減
replace find_time_m=job1_year-sol_etime+1/12 if int(job1_year)>sol_ey&job_mskip==1&sol_em!=0 //工作年份>退伍年份、無工作月、有退伍月->相減+1/12
replace find_time_m=1 if int(job1_year)==sol_ey&job_mskip==1&sol_em==0 //工作與退伍同年、無工作月份、無退伍月份->1/12
replace find_time_m=1-sol_em/12+1/12 if int(job1_year)==sol_ey&job_mskip==1&sol_em!=0 //工作與退伍同年、無工作月份、有退伍月份->1-退伍月/12+1/12
replace find_time_m=job1_year-sol_etime+1/12 if int(job1_year)==sol_ey&job_mskip==0&sol_em!=0 //工作與退伍同年、有工作月份、有退伍月份->相減+1/12
replace find_time_m=job1_year-sol_etime if int(job1_year)==sol_ey&job_mskip==0&sol_em==0 //工作與退伍同年、有工作月份、無退伍月份->相減
*replace find_time_m=job1_year-sol_etime+1/12 if int(job1_year)>=int(sol_etime)&sol_em!=0&job_mskip==0

gen find_skip=.
replace find_skip=job1_year==0|job1_year==9999|job1_year==.|sol_etime==0|sol_etime==.
order number survey_plan find_skip year find_time_m
gsort number find_skip -year find_time_m
by number: replace find_time_m=find_time_m[1] if find_time_m[1]!=9999

keep number sex find_time_m sol_etime
duplicates drop
tempfile find_time_m
save `find_time_m.dta'
restore
merge m:1 number sex using `find_time_m.dta'
drop _merge

*********************************************************世代、did計算
gen male=sex==1
replace soldier_yes=0
replace sol_2stage=0 if sol_2stage==.
replace soldier_yes=1 if soldier==1|sol_2stage!=0|sol_etime>0

gen gn_1=b_year<=69
gen gn_2=b_year>=70&b_year<=73
gen gn_3=b_year>=74&b_year<=82
gen gn_4=b_year>=83

gen did_1=gn_1*male
gen did_2=gn_2*male
gen did_3=gn_3*male
gen did_4=gn_4*male

*********************************************************cross-section data
//有job1_year 就不用seek_time
gen find_time=.
replace find_time=find_time_f if sex==2
replace find_time=find_time_m if sex==1
gen job1_already=find_time!=. //1有第一份正職時間 0否
//若沒有第一份工作尋職期間，用(當前時間-畢業/退伍時間)代替
replace find_time=seek_time if seek_time!=.&job1_already==0&(job1_year!=0|job1_year!=9999|job1_year!=.)

order number survey_plan job1_already find_time seek_time
//以第一份工作尋職期間為優先，找工作時間次之
gsort number -job1_already -year -seek_time //job1_already由大到小  seek_time由大到小
by number: keep if _n==1

order survey_plan number sex b_year job1_already grad_y edu sol_ey sol_em sol_etime

*********************************************************linear regression
reg find_time male eduy gn_1 gn_2 gn_4 did_1 did_2 did_4 

*********************************************************survival regression
drop if missing(find_time)
stset find_time, failure(job1_already)
stcox  male eduy gn_1 gn_2 gn_4 did_1 did_2 did_4, robust
est store a
esttab a using "D:\家庭動態調查\分析\reg_result_gm6.rtf",replace eform se star(* 0.10 ** 0.05 *** 0.01) title("初次求職期間迴歸估計結果")
esttab a using "D:\家庭動態調查\分析\reg_result_gm6_hz.rtf",replace se star(* 0.10 ** 0.05 *** 0.01) title("初次求職期間迴歸估計結果")

stcox  male eduy gn_1 gn_2 gn_4 did_1 did_2 did_4 if b_year>50, robust

foreach i in find_time male eduy gn_1 gn_2 gn_3 gn_4 did_1 did_3 did_2 did_4{
format `i' %9.4f
}
sum find_time male eduy gn_1 gn_2 gn_4 did_1 did_2 did_4

s
capture log close
log using "D:\家庭動態調查\分析\var_stat.log",replace
sum find_time male eduy gn_1 gn_2 gn_3 gn_4 did_1 did_3 did_2 did_4 ,format
log close

keep if did_4==1&find_time==.
drop if soldier==2|soldier==3

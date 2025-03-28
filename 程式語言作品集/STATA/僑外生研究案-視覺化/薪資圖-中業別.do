cd "D:\研究助理工作\僑外生\分析"
use new_data\fcol_pind2,clear

ren wage_m_mcpi mwage_m_cpi
foreach w in wage_i_mcpi mwage_m_cpi {
seperate `w',by ( ind2 )
label var `w'1   不動產經營及相關服務業
label var `w'2   不動產開發業
label var `w'3   人力仲介及供應業
label var `w'4   企業總管理機構及管理顧問業
label var `w'5   住宿業
label var `w'6   保全及偵探業
label var `w'7   保險業
label var `w'8   倉儲業
label var `w'9   個人及家庭用品維修業
label var `w'10  公共行政及國防；強制性社會安全
label var `w'11  其他化學製品製造業
label var `w'12  其他專業、科學及技術服務業
label var `w'13  其他社會工作服務業
label var `w'14  其他製造業
label var `w'15  其他運輸工具及其零件製造業
label var `w'16  出版業
label var `w'17  創作及藝術表演業
label var `w'18  化學材料及肥料製造業
label var `w'19  博弈業
label var `w'20  博物館、歷史遺址及類似機構
label var `w'21  印刷及資料儲存媒體複製業
label var `w'22  國際組織及外國機構
label var `w'23  圖書館、檔案保存、博物館及類似機構
label var `w'24  土木工程業
label var `w'25  基本金屬製造業
label var `w'26  塑膠製品製造業
label var `w'27  宗教、職業及類似組織
label var `w'28  家具製造業
label var `w'29  專門營造業  
label var `w'30  專門設計業
label var `w'31  居住型照顧服務業
label var `w'32  廢棄物清除、處理及資源物回收處理業
label var `w'33  廢水及污水處理業
label var `w'34  廣告業及市場研究業
label var `w'35  廣播、電視節目編排及傳播業
label var `w'36  建物裝潢業
label var `w'37  建築、工程服務及技術檢測、分析服務業
label var `w'38  建築工程業
label var `w'39  建築物及綠化服務業
label var `w'40  影片及電視節目業；聲音錄製及音樂發行業
label var `w'41  成衣及服飾品製造業
label var `w'42  教育業
label var `w'43  旅行及其他相關服務業
label var `w'44  木竹製品製造業
label var `w'45  未分類其他服務業
label var `w'46  機械設備製造業
label var `w'47  機電、電路及管道工程業
label var `w'48  橡膠製品製造業
label var `w'49  水上運輸業
label var `w'50  污染整治業
label var `w'51  汽車及其零件製造業
label var `w'52  法律及會計服務業
label var `w'53  獸醫業
label var `w'54  產業用機械設備維修及安裝業
label var `w'56  皮革、毛皮及其製品製造業
label var `w'57  石油及煤製品製造業
label var `w'58  研究發展服務業
label var `w'59  租賃業
label var `w'60  紙漿、紙及紙製品製造業
label var `w'61  紡織業
label var `w'62  航空運輸業
label var `w'63  藥品及醫用化學製品製造業
label var `w'64  行政支援服務業
label var `w'65  證券期貨及金融輔助業
label var `w'66  資訊服務業
label var `w'67  運動、娛樂及休閒服務業
label var `w'68  運輸輔助業
label var `w'69  郵政及遞送服務業
label var `w'70  醫療保健業
label var `w'71  金屬製品製造業
label var `w'72  金融服務業
label var `w'73  陸上運輸業
label var `w'74  電信業
label var `w'75  電力及燃氣供應業
label var `w'76  電力設備及配備製造業
label var `w'77  電子零組件製造業
label var `w'78  電腦、電子產品及光學製品製造業
label var `w'79  電腦程式設計、諮詢及相關服務業
label var `w'80  非金屬礦物製品製造業
label var `w'81  餐飲業
}




local r=1
foreach i in  1 4 7 10 13 16{

local o=`i'
local p=`i'+1
local q=`i'+2

twoway line wage_i_mcpi`o' wage_i_mcpi`p' wage_i_mcpi`q' times if part==0,/*
*/ylab(10000(20000)50000,angle(horizontal))  ytick(10000(10000)50000) /*
*/xlab(2012(2)2022)  xtick(2012(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("勞保薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_中業別勞保薪資")subtitle("單位:元", position(1)size(3))
graph export "new_graph\ind2_wi`r'.png", replace
local r=`r'+1	

}
/*
twoway line semp1- semp81 times,/*
*/ylab(0(1000)5000,angle(horizontal))  ytick(0(500)5000) /*
*/xlab(2012(2)2022)  xtick(2012(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("勞保薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_各業別勞保薪資")subtitle("單位:元", position(1)size(3))
graph export "graph\ind2_emp`r'.png", replace
*/




local r=1
foreach i in  1 7 10 13 16{

local o=`i'
local p=`i'+1
local q=`i'+2

twoway line mwage_m_cpi`o' mwage_m_cpi`p' mwage_m_cpi`q' times if part==0,/*
*/ylab(20000(20000)60000,angle(horizontal))  ytick(20000(10000)60000) /*
*/xlab(2012(2)2022)  xtick(2012(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("月薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_中業別月薪資")subtitle("單位:元", position(1)size(3))
graph export "new_graph\ind2_wm`r'.png", replace
local r=`r'+1	

}

local r=2
foreach i in  4{

local o=`i'
local p=`i'+1
local q=`i'+2

twoway line mwage_m_cpi`o' mwage_m_cpi`p' mwage_m_cpi`q' times if part==0,/*
*/ylab(20000(20000)80000,angle(horizontal))  ytick(20000(10000)80000) /*
*/xlab(2012(2)2022)  xtick(2012(1)2022) lc( maroon dknavy ) mc( maroon dknavy) clp(l -.-) msymbol(o t s) lw(thin thin) msize(small small)/*
*/scheme(sj) ysize(2) xsize(4)/*
*/ytitle("月薪資") /*
*/xtitle("時間",width(30) height(6)size(3)) /*
*/title("僑外生_中業別月薪資")subtitle("單位:元", position(1)size(3))
graph export "new_graph\ind2_wm`r'.png", replace
local r=`r'+1	

}



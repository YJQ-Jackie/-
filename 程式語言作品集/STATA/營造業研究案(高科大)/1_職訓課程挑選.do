cd "D:\營造業"

foreach i in "營建" "營造" "泥水" "泥土" "混凝" "配管" "配線" "防水" "測量" "建築" "橋梁"/*
*/ "造園" "配電" "線路" "電纜" "裝潢" "裝修" "下水道" "景觀" "修繕" "水電" "土木" "改建"/*
*/ "營繕" "隧道工程"{
use "D:\營造業\0925攜出\lesson.dta",clear
keep if strmatch(課程名稱,"*`i'*")==1
tempfile lesson_`i'
save `lesson_`i''.dta,replace
}

foreach i in "營建" "營造" "泥水" "泥土" "混凝" "配管" "配線" "防水" "測量" "建築" "橋梁"/*
*/ "造園" "配電" "線路" "電纜" "裝潢" "裝修" "下水道" "景觀" "修繕" "水電" "土木" "改建"/*
*/ "營繕" "隧道工程"{
append using `lesson_`i''.dta
}
drop if strmatch(課程名稱,"*電機*")==1
duplicates drop

foreach i in "客戶關係" "背板設計線條營造立體感" "社區營造與地方觀光特色再造" "團隊向心力營造"/*
*/ "社區觀光發展" "氣氛" "營造嚮往與臨場感" "社群營造" "氛圍" "職場營造" "失智" "社區安全營造"/*
*/ "醫療營造" "團隊營造" "團隊合作營造" "長照" "文化營造" "客訴" "營造多元教學環境與規劃"/*
*/ "相機" "行銷" "文化" "旅" "硬體" "世界" "西班牙" "日式" "族群" "著名" "日本" "歐"/*
*/ "法國" "客家" "西洋" "文藝" "西亞" "福爾摩沙" "廟宇" {
drop if strmatch(課程名稱,"*`i'*")==1
}

save lesson_ci,replace
export excel using "D:\營造業\職訓課程名稱.xlsx",replace

use "D:\營造業\0925攜出\lesson.dta",clear
keep if strmatch(課程名稱,"*升降*")==1|strmatch(課程名稱,"*昇降*")==1
save lesson_ci_昇降,replace

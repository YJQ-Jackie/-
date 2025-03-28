import pandas as pd
import numpy as np
import os

# 設定資料夾路徑
data_path = r"\\192.168.1.105\112年度\ilosh112-M221_僑外生在臺就業追蹤分析之研究\data"

# 讀取工讀檔（fstudent2）
fstudent2 = pd.read_parquet(os.path.join(data_path, "fstudent2.parquet"))
fstudent2.dropna(subset=['id2'], inplace=True)

# 生成 temp1, temp2
temp1 = fstudent2.sort_values('id2')[['id1', 'id2']]
temp1.to_parquet(os.path.join(data_path, "temp1.parquet"))

temp2 = fstudent2.sort_values('id1')
temp2.to_parquet(os.path.join(data_path, "temp2.parquet"))

# 處理每年每月的勞保檔
for year in range(2004, 2024):
    months = [f"{m:02d}" for m in range(1, 13)]
    if year == 2023:
        months = ["01", "02"]

    for month in months:
        print(f"Processing Year={year} Month={month}")

        # 讀取勞保檔
        file_path = os.path.join(data_path, f"iinsuree_{year}{month}.parquet")
        if not os.path.exists(file_path):
            print(f"File not found: {file_path}")
            continue

        insuree = pd.read_parquet(file_path)

        # 合併護照號碼
        insuree['id1'] = insuree['id']
        merge_id1 = insuree.merge(temp2, on='id1', how='left', indicator=True)
        merge_id1 = merge_id1[merge_id1['_merge'].isin(['both', 'right_only'])]
        merge_id1.drop('id2', axis=1, inplace=True)

        temp_file = os.path.join(data_path, f"temp_{year}{month}.parquet")
        merge_id1.to_parquet(temp_file)

        # 合併居留證號
        insuree['id2'] = insuree['id']
        merge_id2 = insuree.merge(temp1, on='id2', how='left', indicator=True)
        merge_id2 = merge_id2[merge_id2['_merge'].isin(['both', 'right_only'])]

        # 合併兩個結果
        combined = pd.concat([merge_id1, merge_id2], ignore_index=True).drop_duplicates()
        combined['year'] = year
        combined['month'] = month

        # 儲存結果
        combined_file = os.path.join(data_path, f"merge_lb_{year}{month}.parquet")
        combined.to_parquet(combined_file)


# 讀取工讀檔的護照號碼與居留證號
temp2 = pd.read_parquet("fstudent2.parquet").dropna(subset=['id2'])
temp2 = temp2.sort_values('id1')
temp2.to_parquet("temp2.parquet", index=False)

temp1 = temp2.copy()
temp1 = temp1.sort_values('id2')
temp1.to_parquet("temp1.parquet", index=False)

"""勞保併工讀檔"""
# 用勞保檔併工讀檔
for year in range(2004, 2024):
    for month in range(1, 13):
        month_str = f"{month:02d}"
        # Load current month's data
        data_path = f"iinsuree_{year}{month_str}.parquet"
        data = pd.read_parquet(data_path)

        print(f"****************************************\nYear={year} Month={month_str}\n****************************************")

        # 依照護照號碼併檔
        data['id1'] = data['id']
        data = data.sort_values('id1')
        merged_data = pd.merge(data, temp2[['id1', 'id2']], on='id1', how='left')
        merged_data = merged_data[merged_data['_merge'].isin([2, 3])]

        # 處理居留證號併檔
        merged_data['id2'] = merged_data['id']
        merged_data = merged_data.sort_values('id2')
        merged_data = pd.merge(merged_data, temp1[['id2']], on='id2', how='left')
        merged_data = merged_data[merged_data['_merge'].isin([2, 3])]

        # 合併結果儲存
        merged_data['year'] = year
        merged_data['month'] = month
        merged_data.to_parquet(f"merge_lb_{year}{month_str}.parquet", index=False)
        


""""併事業單位資料"""
# 併入事業單位資料
for year in range(2008, 2024):
    for month in range(1, 13):
        print(f"****************************************\nYear={year} Month={month}\n****************************************")
        
        lb_data = pd.read_parquet(f"merge_lb_{year}{month:02d}.parquet").dropna(subset=['firmid'])
        lb_data = lb_data.drop_duplicates(subset=['id', 'firmid'])

        # 併事業單位
        if (year == 2016 and month >= 8) or year >= 2017:
            firms_data = pd.read_parquet(f"firms_{year}{month:02d}.parquet")
            lb_data = pd.merge(lb_data, firms_data[['firmid']], on='firmid', how='left', indicator=True)
            lb_data = lb_data[lb_data['_merge'].isin([1, 3])]

        lb_data.to_parquet(f"combineall{year}{month:02d}.parquet", index=False)

# 組合所有資料
combined_data = pd.DataFrame()
for year in range(2008, 2024):
    for month in range(1, 13):
        month_str = f"{month:02d}"
        monthly_data = pd.read_parquet(f"combineall{year}{month_str}.parquet")
        combined_data = pd.concat([combined_data, monthly_data], ignore_index=True)

combined_data = combined_data.sort_values(['id', 'year', 'month'])
combined_data.to_parquet("combineall.parquet", index=False)

# 去除重複的 id
combined_data = combined_data.drop_duplicates(subset='id', keep='first')

""""併行業分類"""
# 行業分類檔案路徑
file_path1 = r"\\192.168.1.105\112年度\ilosh112-M221_僑外生在臺就業追蹤分析之研究\data\行業分類1.parquet"
file_path2 = r"\\192.168.1.105\112年度\ilosh112-M221_僑外生在臺就業追蹤分析之研究\data\行業分類2.parquet"
file_path3 = r"\\192.168.1.105\112年度\ilosh112-M221_僑外生在臺就業追蹤分析之研究\data\行業分類3.parquet"
file_path4 = r"\\192.168.1.105\112年度\ilosh112-M221_僑外生在臺就業追蹤分析之研究\data\行業分類4.parquet"

# 大業別
cate_industry = pd.read_parquet(file_path1) 
combined_data = pd.merge(combined_data, cate_industry, how='left', on='id') 
combined_data = combined_data[combined_data['_merge'] != 2]  
combined_data = combined_data.drop(columns=['_merge']) 

# 中業別
combined_data['indcode2'] = combined_data['indcode'].str[:2] 
industry2 = pd.read_parquet(file_path2) 
combined_data = pd.merge(combined_data, industry2, how='left', on='indcode2') 
combined_data = combined_data[combined_data['_merge'] != 2]  
combined_data = combined_data.drop(columns=['_merge']) 

# 小業別
combined_data['indcode3'] = combined_data['indcode'].str[:3] 
industry3 = pd.read_parquet(file_path3)
combined_data = pd.merge(combined_data, industry3, how='left', on='indcode3')
combined_data = combined_data[combined_data['_merge'] != 2]  
combined_data = combined_data.drop(columns=['_merge'])

# 細業別
industry4 = pd.read_parquet(file_path4)  
combined_data = pd.merge(combined_data, industry4, how='left', on='indcode')
combined_data = combined_data[combined_data['_merge'] != 2]
combined_data = combined_data.drop(columns=['_merge']) 

""""併地區資料"""
# 地區檔案路徑
file_path = r"\\192.168.1.105\112年度\ilosh112-M221_僑外生在臺就業追蹤分析之研究\data\地區別.parquet"

# 合併地區檔案
cate_regiarea = pd.read_parquet(file_path)  
combined_data = pd.merge(combined_data, cate_regiarea, how='left', on='id')  

# 生成 area 欄位並替換數值
combined_data['area'] = None  

# 替換 area 欄位的值
area_mapping = {
    "基隆市": 1,
    "新北市": 2,
    "臺北市": 3,
    "桃園市": 4,
    "新竹縣": 5,
    "新竹市": 6,
    "苗栗縣": 7,
    "臺中市": 8,
    "彰化縣": 9,
    "南投縣": 10,
    "雲林縣": 11,
    "嘉義縣": 12,
    "嘉義市": 13,
    "臺南市": 14,
    "高雄市": 15,
    "屏東縣": 16,
    "宜蘭縣": 17,
    "花蓮縣": 18,
    "臺東縣": 19,
    "澎湖縣": 20,
    "金門縣": 21,
    "連江縣": 22
}

# 使用 area_mapping 根據 areanm1 欄位進行替換
combined_data['area'] = combined_data['areanm1'].map(area_mapping)


"""併事業規模檔"""
scale_path = r"\\192.168.1.105\112年度\ilosh112-M221_僑外生在臺就業追蹤分析之研究\data\scale.parquet"
scale = pd.read_parquet(scale_path)

# 合併資料
combined_data = combined_data.merge(scale, how='left', on=['year', 'month', 'firmid'])


"""併專業人才檔"""
f1_path = r"\\192.168.1.105\112年度\ilosh112-M221_僑外生在臺就業追蹤分析之研究\data\f1-1_ver4.parquet"
f1_data = pd.read_parquet(f1_path)


# 合併
combined_data = pd.merge(combined_data, f1_data, how='left', on=['id1', 'year', 'month', 'firmid'], indicator = True)

# 處理 _merge 欄位
combined_data = combined_data[combined_data['_merge'] != 'right_only']

# 重命名欄位
combined_data = combined_data.rename(columns={'_merge': 'merge_p', '是否為評點': 'pd', '月薪資': 'wage_m'})

# 計算新變數 wage_m_cpi
combined_data['wage_m_cpi'] = (combined_data['wage_m'] / combined_data['cpi']) * 100

# 刪除無用的欄位
combined_data = combined_data.drop(columns=['mergeID2', 'mergeID1', '收文文號', 'male'])

# 排序並去除重複值
combined_data = combined_data.sort_values(by=['id', 'times', 'emp_f', '-wage_i', '-wage_m'])
combined_data = combined_data.drop_duplicates(subset=['id', 'times', 'firmid'], keep='first')

"""併 累積打工月"""
work_months_path = r"\\192.168.1.105\112年度\ilosh112-M221_僑外生在臺就業追蹤分析之研究\data\work_months.parquet"
work_months = pd.read_parquet(work_months_path)

combined_data = pd.merge(combined_data, work_months, how='left', on='id')

"""併 學歷資料"""
file_path = r"\\192.168.1.105\112年度\ilosh112-M221_僑外生在臺就業追蹤分析之研究\data\學歷n2.parquet"
school_data = pd.read_parquet(file_path)
combined_data = pd.merge(combined_data, school_data, how='left', on='id')

"""併 國籍資料"""
file_path = r"\\192.168.1.105\112年度\ilosh112-M221_僑外生在臺就業追蹤分析之研究\data\country.parquet"
country_data = pd.read_parquet(file_path)
combined_data = pd.merge(combined_data, country_data, how='left', on='id')

# 針對同一人曾用不同證件投保的處理
# 假設某些 id1 的資料要合併為 id2
id_list = ["*********", "*********", "*********", "*********"]  # 要替換成真實的 id1 值

for i in id_list:
    # 找出相應 id 的資料
    person_data = combined_data[combined_data['id1'] == i]

    # 顯示對應 id 的資料
    print(person_data)

    # 將 id1 替換為 id2
    combined_data.loc[combined_data['id1'] == i, 'id'] = combined_data.loc[combined_data['id1'] == i, 'id2']

    # 刪除 id1 投保時無工作的紀錄
    combined_data = combined_data[~((combined_data['id'] == i) & combined_data['firmid'].isna())]

    # 保留有工作的資料
    working_data = combined_data[(combined_data['id1'] == i) & combined_data['firmid'].notna()]

    # 保留有工作的時間
    working_data = working_data[['times', 'id']].drop_duplicates()

    # 保存有工作資料
    working_data.to_pickle("working_data.pkl")

    # 重新合併工作資料
    combined_data = pd.merge(combined_data, working_data, how='left', on=['times', 'id'])

    # 刪除無工作期間的資料
    combined_data = combined_data[~((combined_data['_merge'] == 3) & combined_data['firmid'].isna())]

    # 去除重複資料
    combined_data = combined_data.drop_duplicates()

# 進行其他變數處理
combined_data['emp'] = (combined_data['wage_i'] > 0) & (combined_data['wage_i'] < combined_data['wage_i'])
combined_data['emp_f'] = (combined_data['wage_i'] > 0) & (combined_data['wage_i'] < combined_data['wage_i']) & (combined_data['wgrp'] > 1)

# 刪除不需要的變數
combined_data = combined_data.drop(columns=['year_s', 'month_s', 'n', 'duration', 'year_e', 'month_e', 'enddate', 'startdate1', 'starty', 'startm', 'enddate1', 'endy', 'endm', 'startdate', 'worktimes'])

# 儲存結果
combined_data.to_parquet(r"\\192.168.1.105\112年度\ilosh112-M221_僑外生在臺就業追蹤分析之研究\data\combineall_e.parquet", write_index=False)

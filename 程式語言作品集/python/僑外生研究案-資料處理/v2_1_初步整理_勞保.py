"""勞保資料整理"""
import pandas as pd
import os

# 設定檔案路徑
base_path = r"\\192.168.1.105\112年度\ilosh112-M221_僑外生在臺就業追蹤分析之研究\data"

# 處理 2009/01-2023/02 勞保資料
for year in range(2009, 2024):
    months = [f"{m:02d}" for m in range(1, 13)]
    if year == 2023:
        months = ["01", "02"]  # 2023年只處理1月和2月
    
    for month in months:
        # 讀取 parquet 檔案
        file_path = os.path.join(base_path, f"勞就保被保人_{year}{month}.parquet")
        
        if not os.path.exists(file_path):
            print(f"檔案不存在: {file_path}")
            continue
        
        df = pd.read_parquet(file_path)

        # 生成 year 和 month
        df['year'] = year
        df['month'] = int(month)

        # 年齡計算 (2009-2015 版本)
        if year <= 2015:
            df['age'] = year - 1911 - df['bd_y']
        else:
            # 生日處理 (處理字串或數字格式的 bd 欄位)
            if df['bd'].dtype == 'int64':
                df['byear'] = df['bd'] // 100
                df['bmonth'] = df['bd'] % 100
            else:
                df['byear'] = df['bd'].str[:4].astype(int)
                df['bmonth'] = df['bd'].str[5:7].astype(int)
            df['age'] = (year - df['byear']) + (int(month) - df['bmonth']) / 12

        # 外籍勞工標記
        df['fw'] = df['pbforeigner_reg'] == 'F'

        # 生成統計欄位
        grouped = df.groupby('insuno')
        df['emp_f'] = grouped['fw'].transform('sum')  # 僑外生員工數
        df['part'] = df['depa'] == 'P'
        df['emp_p'] = grouped['part'].transform('sum')  # 兼職人數
        df['emp'] = grouped.size()  # 員工總數
        df['mwage'] = grouped['insuwage'].transform('mean')  # 平均薪資
        df['mage'] = grouped['age'].transform('mean')  # 平均年齡
        df['maleratio'] = grouped['male'].transform('mean')  # 男性比例

        # 取每個 insuno 第一筆記錄
        df = df.drop_duplicates(subset='insuno', keep='first')

        # 欄位排序與選擇
        df = df[['year', 'month', 'idcardno', 'insuno', 'insuwage', 'mage', 'maleratio',
                 'mwage', 'emp', 'emp_p', 'emp_f']]
        df.rename(columns={'insuno': 'firmid'}, inplace=True)

        # 輸出 parquet
        output_path = os.path.join(base_path, f"insuree_{year}{month}.parquet")
        df.to_parquet(output_path, index=False)
        print(f"已儲存: {output_path}")

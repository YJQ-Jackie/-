"""單位檔整理 2016/08-2023/03
單位檔最早只到2016/08，故2016/07以前的單位資料用2016/08以後的資料獲取
"""
import pandas as pd
import os

# 函數: 處理單位檔
def process_firms(start_year, end_year, months, input_path, output_path):
    for year in range(start_year, end_year + 1):
        for month in months:
            file_name = f"單位檔_{year}{month}.parquet"
            input_file = os.path.join(input_path, file_name)

            # 讀檔
            df = pd.read_parquet(input_file)

            # 新增年變數、月變數
            df['year'] = year
            df['month'] = month

            # 保留重要變數
            columns_to_keep = [
                'date_ym', 'insuno', 'ma_fr', 'cate_regiarea', 'indcode',
                'ret_avewage_busicate', 'insnum_endm', 'avewage_busicate', 'cate_industry'
            ]
            df = df[columns_to_keep]

            df.rename(columns={'insuno': 'firmid'}, inplace=True)

            # 以frimid排序
            df.sort_values(by='firmid', inplace=True)

            # 存檔
            output_file = os.path.join(output_path, f"firms_{year}{month}.parquet")
            df.to_parquet(output_file, index=False)

input_path = "\\\\192.168.1.105\\112年度\\ilosh112-M221_僑外生在臺就業追蹤分析之研究\\data"
output_path = input_path

# 處理 2016/08-2023/03 的單位檔
process_firms(2016, 2016, ["08", "09", "10", "11", "12"], input_path, output_path)
process_firms(2017, 2022, [f"{month:02}" for month in range(1, 13)], input_path, output_path)
process_firms(2023, 2023, ["01", "02", "03"], input_path, output_path)


# 以下函數用於獲取2016年7月以前的事業單位資料
def compile_firm_info(start_year, end_year, months, input_path, output_path):
    all_dfs = []

    for year in range(start_year, end_year + 1):
        if year == 2016:
            months = ["08", "09", "10", "11", "12"]
        elif year == 2023:
            months = ["01", "02", "03"]
        for month in months:
            file_name = f"單位檔_{year}{month}.parquet"
            input_file = os.path.join(input_path, file_name)

            df = pd.read_parquet(input_file)

            columns_to_keep = ['insuno', 'uni_no', 'ma_id', 'cate_regiarea', 'indcode', 'cate_industry']
            df = df[columns_to_keep]

            all_dfs.append(df)

    combined_df = pd.concat(all_dfs, ignore_index=True)

    # 刪除同時重複 'insuno', 'ma_id', 'uni_no' 的值
    combined_df.drop_duplicates(subset=['insuno', 'ma_id', 'uni_no'], keep='first', inplace=True)

    # 去除'uni_no'變數的空格
    combined_df['uni_no'] = combined_df['uni_no'].str.replace(" ", "", regex=True)

    # 存檔
    firms_info_file = os.path.join(output_path, "firms_info.parquet")
    combined_df.to_parquet(firms_info_file, index=False)

    # 刪除重複 'insuno' 的值
    firms_clear_df = combined_df.drop_duplicates(subset=['insuno'])
    firms_clear_df = firms_clear_df[['insuno', 'cate_regiarea', 'indcode', 'cate_industry']]

    # 重新命名
    firms_clear_df.rename(columns={'insuno': 'firmid', 'cate_regiarea': 'region', 'indcode': 'IndCode', 'cate_industry': 'cate'}, inplace=True)

    # 存檔
    firms_clear_file = os.path.join(output_path, "firms_clear.parquet")
    firms_clear_df.to_parquet(firms_clear_file, index=False)

# Compile data from 2016-2023
compile_firm_info(2016, 2023, [f"{month:02}" for month in range(1, 13)], input_path, output_path)

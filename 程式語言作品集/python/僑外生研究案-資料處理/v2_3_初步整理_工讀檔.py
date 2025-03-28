import pandas as pd
import numpy as np
import os

def process_fstudent(input_file, output_path, lb_id_file):
    df = pd.read_parquet(input_file)

    # 每個僑外生只保留一筆資料
    df.sort_values(by=['護照號碼', '發文日期'], inplace=True)
    df.drop_duplicates(subset='護照號碼', keep='first', inplace=True)

    drop_cols = ['申請工作起日', '申請工作迄日', '實際工作起日', '實際工作迄日', '發文日期', '收文文號', '申請類別', '申請項目', '分類']
    df.drop(columns=drop_cols, inplace=True)

    # 將護照號碼、居留證號存在 fstudent2 檔
    fstudent2 = df[['護照號碼', '居留證號']].rename(columns={'護照號碼': 'id1', '居留證號': 'id2'})
    fstudent2.to_parquet(os.path.join(output_path, 'fstudent2.parquet'), index=False)

    # 建立工作起訖時間
    df['id1'] = df['護照號碼']

    df['year_s'] = df['實際工作起日'].str[:4].astype(int)
    df['month_s'] = df['實際工作起日'].str[4:6].astype(int)
    df['year_e'] = df['實際工作迄日'].str[:4].astype(int)
    df['month_e'] = df['實際工作迄日'].str[4:6].astype(int)

    df['duration'] = (df['year_e'] - df['year_s']) * 12 + (df['month_e'] - df['month_s']) + 1

    df.drop_duplicates(subset=['id1', 'year_s', 'month_s', 'year_e', 'month_e', 'duration'], keep='first', inplace=True)

    # 以工讀期間擴展擴展資料 (panel)
    df = df.loc[df.index.repeat(df['duration'])].reset_index(drop=True)

    # 產生年、月變數
    df['n'] = df.groupby(['id1', 'year_s', 'month_s', 'year_e', 'month_e', 'duration']).cumcount() + 1
    df['year'] = df['year_s'] + (df['n'] + df['month_s'] - 2) // 12
    df['month'] = (df['month_s'] + df['n'] - 1 - 1) % 12 + 1

    # 同時間只保留一筆工讀申請
    df.drop_duplicates(subset=['id1', 'year', 'month'], keep='first', inplace=True)

    # 計算申請工讀總月數
    work_months = df.groupby('id1').size().reset_index(name='work_months')

    # 用勞保ID合併
    lb_id = pd.read_parquet(lb_id_file)
    merged = pd.merge(work_months, lb_id, on='id1', how='outer', indicator=True)

    # 儲存有併到勞保ID的工讀資料
    merged_matched = merged[merged['_merge'] == 'both'].drop('_merge', axis=1)
    merged_matched.to_parquet(os.path.join(output_path, 'work_months.parquet'), index=False)

    # 計算有投保的工讀月數
    work_times = df.groupby('id1').size().reset_index(name='work_times')
    work_times.to_parquet(os.path.join(output_path, 'work_times.parquet'), index=False)

# Paths
input_file = "\\\\192.168.1.105\\112年度\\ilosh112-M221_僑外生在臺就業追蹤分析之研究\\data\\f1-2.parquet"
output_path = "\\\\192.168.1.105\\112年度\\ilosh112-M221_僑外生在臺就業追蹤分析之研究\\data"
lb_id_file = "\\\\192.168.1.105\\112年度\\ilosh112-M221_僑外生在臺就業追蹤分析之研究\\data\\lb_id.parquet"

process_fstudent(input_file, output_path, lb_id_file)

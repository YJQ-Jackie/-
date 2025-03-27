import pandas as pd
import numpy as np

"""專業人才檔 (以每次申請作為資料紀錄)"""
f1_path = r"\\192.168.1.105\112年度\ilosh112-M221_僑外生在臺就業追蹤分析之研究\data\f1-1.parquet"
firms_info_path = r"\\192.168.1.105\112年度\ilosh112-M221_僑外生在臺就業追蹤分析之研究\data\firms_info.parquet"

f1 = pd.read_parquet(f1_path)
firms_info = pd.read_parquet(firms_info_path)

# 排序並刪除重複值 (保留薪資高的資料)
f1.sort_values(by=["護照號碼", "實際工作起日", "實際工作迄日", "雇主統編", "月薪資"], ascending=[True, True, True, True, False], inplace=True)
f1.drop_duplicates(subset=["護照號碼", "實際工作起日", "實際工作迄日", "雇主統編"], keep='first', inplace=True)

# 工讀檔用 "雇主統編" 併單位檔資料
f1["uni_no"] = f1["雇主統編"]
f1_uni_merge = f1.merge(firms_info, left_on="uni_no", right_on="uni_no", how="outer", indicator="merge_uni")
f1_uni_merge = f1_uni_merge[(f1_uni_merge["merge_uni"] == "both") | (f1_uni_merge["merge_uni"] == "left_only")]

# 暫存檔案
temp_path = r"\\192.168.1.105\112年度\ilosh112-M221_僑外生在臺就業追蹤分析之研究\data\temp.parquet"
f1_uni_merge.to_parquet(temp_path, index=False)

# 工讀檔用 "ma_id" 併單位檔資料
f1 = pd.read_parquet(f1_path) 
f1["ma_id"] = f1["雇主統編"]
f1_ma_merge = f1.merge(firms_info, left_on="ma_id", right_on="uni_no", how="outer", indicator="merge_ma")
f1_ma_merge = f1_ma_merge[(f1_ma_merge["merge_ma"] == "both") | (f1_ma_merge["merge_ma"] == "left_only")]

f1_combined = pd.concat([f1_uni_merge, f1_ma_merge])

# 同時間同雇主保留最高薪資的資料
f1_combined.sort_values(by=["護照號碼", "實際工作起日", "實際工作迄日", "雇主統編", "月薪資"], ascending=[True, True, True, True, False], inplace=True)
f1_combined.drop_duplicates(subset=["護照號碼", "實際工作起日", "實際工作迄日", "雇主統編", "firmid"], keep='first', inplace=True)

# 保留有合併到的資料
f1_combined = f1_combined[(f1_combined["merge_ma"] == "both") | (f1_combined["merge_uni"] == "both")]

# 存檔
output_path = r"\\192.168.1.105\112年度\ilosh112-M221_僑外生在臺就業追蹤分析之研究\data\f1-1_ver3.parquet"
f1_combined.to_parquet(output_path, index=False)


"""專業人才檔 (以每次申請作為資料紀錄) -> 專業人才紀錄檔 (將每次申請的工作期間擴展為年月，改以年月作為資料記錄)"""
f1_expanded = pd.read_parquet(output_path)

# 新增工作起訖日變數
f1_expanded["year_s"] = f1_expanded["實際工作起日"].astype(str).str[:4].astype(int)
f1_expanded["month_s"] = f1_expanded["實際工作起日"].astype(str).str[4:6].astype(int)

f1_expanded["year_e"] = f1_expanded["實際工作迄日"].astype(str).str[:4].astype(int)
f1_expanded["month_e"] = f1_expanded["實際工作迄日"].astype(str).str[4:6].astype(int)

# 計算工作期間
f1_expanded["duration"] = (f1_expanded["year_e"] - f1_expanded["year_s"]) * 12 + (f1_expanded["month_e"] - f1_expanded["month_s"]) + 1

# 以工作期間擴展資料 (panel data)
expanded_rows = []
for _, row in f1_expanded.iterrows():
    for i in range(row["duration"]):
        new_row = row.copy()
        new_row["n"] = i + 1
        year = row["year_s"] + (row["month_s"] + i - 1) // 12
        month = (row["month_s"] + i - 1) % 12 + 1
        new_row["year"] = year
        new_row["month"] = month
        expanded_rows.append(new_row)

f1_expanded = pd.DataFrame(expanded_rows)

f1_expanded.drop(columns=["cate_regiarea", "indcode", "cate_industry", "申請工作起日", "申請工作迄日", "國籍"], inplace=True)

f1_expanded.rename(columns={"護照號碼": "id1"}, inplace=True)

# 存檔
final_output_path = r"\\192.168.1.105\112年度\ilosh112-M221_僑外生在臺就業追蹤分析之研究\data\f1-1_ver4.parquet"
f1_expanded.to_parquet(final_output_path, index=False)

print("Processing completed and saved to f1-1_ver4.parquet")

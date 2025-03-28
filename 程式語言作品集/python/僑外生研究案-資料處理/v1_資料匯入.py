import pandas as pd
import os

# 定義路徑
input_base = r"\\192.168.1.105\112年度\ilosh112-M221_僑外生在臺就業追蹤分析之研究\原始檔"
output_base = r"\\192.168.1.105\112年度\ilosh112-M221_僑外生在臺就業追蹤分析之研究\data"

# 確保輸出資料夾存在
os.makedirs(output_base, exist_ok=True)

# 讀取並保存 CSV 的函式
def process_csv(input_folder, output_folder, prefix, years, months):
    for year in years:
        for month in months:
            input_path = os.path.join(input_folder, f"{prefix}{year}{month}.csv")
            output_path = os.path.join(output_folder, f"{prefix}{year}{month}.parquet")

            # 如果檔案存在，則讀取和保存
            if os.path.exists(input_path):
                print(f"正在處理: {input_path}")
                df = pd.read_csv(input_path, encoding='big5')
                df.to_parquet(output_path, index=False)
                print(f"已儲存: {output_path}")
            else:
                print(f"檔案不存在: {input_path}")

# 1. 處理舊提繳對象 (2005-2016)
process_csv(
    input_folder=os.path.join(input_base, "舊提繳對象"),
    output_folder=output_base,
    prefix="提繳",
    years=list(range(2005, 2017)),
    months=[f"{m:02}" for m in range(1, 13)]
)

# 2. 處理提繳對象 (2016-2023)
process_csv(
    input_folder=input_base,
    output_folder=output_base,
    prefix="提繳對象_",
    years=list(range(2016, 2024)),
    months=[f"{m:02}" for m in range(1, 13)]
)

# 3. 處理事業單位檔 (2016-2023)
process_csv(
    input_folder=input_base,
    output_folder=output_base,
    prefix="提繳(投保)單位檔_",
    years=list(range(2016, 2024)),
    months=[f"{m:02}" for m in range(1, 13)]
)

# 4. 處理舊被保人 (2004-2015)
process_csv(
    input_folder=os.path.join(input_base, "舊被保人"),
    output_folder=output_base,
    prefix="被保人",
    years=list(range(2004, 2016)),
    months=[f"{m:02}" for m in range(1, 13)]
)

# 5. 處理勞就保被保人 (2016-2023)
process_csv(
    input_folder=input_base,
    output_folder=output_base,
    prefix="勞就保被保人_",
    years=list(range(2016, 2024)),
    months=[f"{m:02}" for m in range(1, 13)]
)

# 6. 處理僑外生資料 (Excel 和 CSV)
excel_files = [
    ("發展署提供外籍專業人才及僑外生資料", "1-1.xlsx", "f1-1.parquet"),
    ("發展署提供外籍專業人才及僑外生資料", "1-2.xlsx", "f1-2.parquet"),
    ("發展署提供外籍專業人才及僑外生資料", "2.csv", "f2.parquet"),
    ("發展署提供外籍專業人才及僑外生資料", "3.csv", "f3.parquet"),
]

for folder, in_file, out_file in excel_files:
    input_path = os.path.join(input_base, folder, in_file)
    output_path = os.path.join(output_base, out_file)

    if os.path.exists(input_path):
        print(f"正在處理: {input_path}")
        if in_file.endswith('.xlsx'):
            df = pd.read_excel(input_path, engine='openpyxl')
        else:
            df = pd.read_csv(input_path, encoding='big5')

        if "3.csv" in in_file:
            df.drop(df.index[:7], inplace=True)
            df.columns = [
                "收文日", "發文日", "文號", "申請業別", "申請項目", "雇主名稱", "統一編號", "地址",
                "外國人姓名", "薪資", "年總薪資", "國籍別", "護照號碼", "居留證號", "性別", "生日",
                "預定聘僱起日", "聘僱起日", "申請狀態"
            ]

        df.to_parquet(output_path, index=False)
        print(f"已儲存: {output_path}")
    else:
        print(f"檔案不存在: {input_path}")

# 7. 處理 CPI 月資料
cpi_path = os.path.join(output_base, "cpi_m.xlsx")
cpi_output = os.path.join(output_base, "cpi_m.parquet")
if os.path.exists(cpi_path):
    df_cpi = pd.read_excel(cpi_path, sheet_name="Sheet1", engine='openpyxl')
    df_cpi.to_parquet(cpi_output, index=False)
    print(f"已儲存: {cpi_output}")
else:
    print(f"CPI 資料不存在: {cpi_path}")

print("全部處理完成")
 

#立委、總統:鄉(鎮、市、區)別
#縣市長:行政區別
import os
os.chdir("D:\\研究助理工作\\選舉資料\\選舉（各選區得票率）")
path = os.getcwd()
import re
import pandas as pd
import numpy as np
def election(filename, fpath, pi, pj):
    # 指定要讀取的xls檔案路徑
    elec_file = os.path.join(fpath, filename)
    print(elec_file)
    # 使用pandas的read_excel函數讀取xls檔案
    data = pd.read_excel(elec_file)
    #欄位數量 ((後8行
    n=data.shape[1]
    
    if ("區域" in filename and "2020.1" in fpath) or ("不分區" in filename and "2020.1" in fpath) or ("區域" in filename and "2024.1" in fpath):
        b = np.where(data == "各候選人得票情形")
    else:
        b=np.where(data == "各政黨得票情形")
    for i in range(b[1][0],n-8):
        data.iloc[0,i]=data.iloc[1,i] #欄位往上覆蓋
        if "民主進步黨" in data.iloc[0,i]:
            data.iloc[0,i]="民進黨"
        elif "中國國民黨" in data.iloc[0,i]:
            data.iloc[0,i]="國民黨"
    
    #dta_name={舊欄位名稱1:新欄位名稱1,舊欄位名稱2:新欄位名稱2,...}
    dta_name={}
    for i in range(0,n):
        dta_name[data.columns[i]]=data.iloc[0,i]
    new_data = data.rename(columns=dta_name) #重新命名欄位名稱
    if "鄉(鎮、市、區)別" in new_data.columns:
        new_data = new_data[new_data["鄉(鎮、市、區)別"].isna()==False]
    elif "行政區別" in new_data.columns:
        new_data = new_data[new_data["行政區別"]!="\u3000\u3000"]
    #new_data[new_data["鄉(鎮、市、區)別"]!=nan] #刪除內容為全形空格的行政區別
    #行政區別 \u3000\u3000
    #刪掉內容為NA的橫排
    column_to_drop=["村里別"]
    if ("立委" in fpath) and ("不分區" in filename or "村里" not in filename ) and ("2020.1" in fpath):
        column_to_drop.append("投票所別")
    elif "縣市長" in fpath:
        column_to_drop.append("投開票所別")
    new_data = new_data.drop(columns=column_to_drop)
    new_data = new_data.dropna()
    new_data = new_data.drop(index=[0])
    c=np.where(new_data == "總\u3000計")
    if len(c[0])!=0:
        new_data.drop(new_data.index[c[0][0]], inplace=True)
    #new_data = new_data[4:]
    #new_data = new_data[pd.isna(new_data.iloc[:,n-1])!=True]
    
    # 定義一個函數，將字串中的千分位逗號去除並轉換為數值
    def str_to_numeric(x):
        # 如果 x 是字串，且包含逗號，則去除逗號並轉換為數值
        if isinstance(x, str) and ',' in x:
            return pd.to_numeric(x.replace(',', ''), errors='coerce')
        # 如果 x 是字串，但不包含逗號，則檢查是否包含數字，如果有就轉換為數值
        elif isinstance(x, str) and re.search(r'\d', x):
            return pd.to_numeric(x, errors='coerce')
        # 如果 x 不是字串，或者是空值，則保持原樣
        else:
            return x

    # 將資料框中的所有元素應用上述函數，進行格式轉換
    new_data = new_data.applymap(str_to_numeric)

    #建立一個非國民黨亦非民進黨的其他候選人票數dataframe(other_dta)
    #new_data = new_data[2:]
    other_del_col = ['村里別', '國民黨', '投開票所別', '民進黨', 'A\n有效票數\n\nA=1+2+...N', 
       'B\n無效票數\n\n', 'C\n投票數\n\nC=A+B', 'D\n已領未投\n票　　數\nD=E-C',
       'E\n發出票數\n\nE=C+D', 'F\n用餘票數\n\n', 'G\n選舉人數\n\nG=E+F', 'G\n選舉人數\n(原領票數)\nG=E+F',
       'H\n投票率\nH=C/G\n(%)', '有效票數A\nA=1+2+...+N',
       '無效票數B', '投票數C\nC=A+B', '已領未投票數\nD\nD=E-C', '發出票數E\nE=C+D', '用餘票數F',
       '選舉人數G\nG=E+F', '投票率H\nH=C÷G']
    delete_col = ['鄉(鎮、市、區)別', '投開票所別', '行政區別','村里別', '國民黨', '民進黨', 'A\n有效票數\n\nA=1+2+...N',
       'B\n無效票數\n\n', 'C\n投票數\n\nC=A+B', 'D\n已領未投\n票　　數\nD=E-C',
       'E\n發出票數\n\nE=C+D', 'F\n用餘票數\n\n', 'G\n選舉人數\n\nG=E+F', 'G\n選舉人數\n(原領票數)\nG=E+F',
       'H\n投票率\nH=C/G\n(%)', '有效票數A\nA=1+2+...+N',
       '無效票數B', '投票數C\nC=A+B', '已領未投票數\nD\nD=E-C', '發出票數E\nE=C+D', '用餘票數F',
       '選舉人數G\nG=E+F', '投票率H\nH=C÷G']
    KMT_DPP_data = new_data.loc[:,new_data.columns.isin(delete_col)==True]
    other_dta = new_data.loc[:,new_data.columns.isin(other_del_col)!=True]
    #other_dta["其他候選人總票數"] = other_dta.iloc[:,1:].sum(axis=1)
    if "行政區別" in new_data.columns:
        left = KMT_DPP_data.set_index("行政區別")
        right = other_dta.set_index("行政區別")
    elif "鄉(鎮、市、區)別" in new_data.columns:
        left = KMT_DPP_data.set_index("鄉(鎮、市、區)別")
        right = other_dta.set_index("鄉(鎮、市、區)別")
    right.loc[:, ["其他候選人總票數"]] = right.iloc[:, 0:].sum(axis=1)
    right.loc[:, ["其他候選人數"]] = len(right.columns)-1

    #合併
    data_merge = left.join(right)
    data_merge["area"] = data_merge.index

    #新增county變數(從檔名抓縣市名稱)
    if "市" in filename:
        c=filename.rfind("市")
        data_merge["county"] = filename[c-2:c+1]
    elif "縣" in filename:
        c=filename.rfind("縣")
        data_merge["county"] = filename[c-2:c+1]
        
    #新增選區變數(從檔名抓選區)
    if "第" in filename and "區域" in filename:
        e=filename.rfind("第")
        data_merge["elec_area"] = filename[e+1]
    elif "第" not in filename and "區域" in filename:
        data_merge["elec_area"] = "1"
        
    #新增選舉年月變數(從資料夾名抓)
    if "立委" in filename and "2024.1" in fpath:
        data_merge["year"] = 2024
        data_merge["month"] = 1
    elif "立委" in filename and "2020.1" in fpath:
        data_merge["year"] = 2020
        data_merge["month"] = 1
    
    #新增選舉類變數(從檔名抓)
    if "不分區立委" in filename:
        data_merge["election"] = "不分區立委"
    elif "區域立委" in filename:
        data_merge["election"] = "區域立委"
        
    os.chdir("D:\\研究助理工作\\選舉資料\\選舉（各選區得票率）\\已整理")
    os_path = os.getcwd()
    folder_path = os.path.join(os_path,pi,pj)
    if not os.path.exists(folder_path):
    # 如果目標資料夾不存在，則創建它
        os.makedirs(folder_path)
    savepath = os.path.join(folder_path, os.path.splitext(filename)[0] + ".xlsx")
    data_merge.to_excel(savepath, index=False)
# 遍歷目錄中的文件

for i in os.listdir(path):
    if os.path.isdir(os.path.join(path,i))==True and "立委" in i: #i:立委、總統、縣市長資料夾
        #print(i)
        for j in os.listdir(i):
            #print(j) 
            if os.path.isdir(os.path.join(path,i,j))==True and ("2020.1" in j or "2024.1" in j): #j:各屆選舉資料夾
                #print(j)
                for file in os.listdir(os.path.join(path,i,j)) : #file:選舉檔(xlsx,xls)
                    #print(file)
                    #if "平地" in file or "山地" in file: #排除原住民區立選舉
                    if (file.endswith(".xls")==True or file.endswith(".xlsx")==True):
                        file_path = os.path.join(path,i,j)
                        print(file_path, file)
                        #跑function
                        election(filename=file, fpath=file_path, pi=i, pj=j)

    
#################
#總統檔案處理→stata

os.chdir("D:\\研究助理工作\\選舉資料\\選舉（各選區得票率）")
path = os.getcwd()

def president(filename, fpath, pi, pj):
    # 指定要讀取的xls檔案路徑
    elec_file = os.path.join(fpath, filename)
    print(elec_file)
    # 使用pandas的read_excel函數讀取xls檔案
    data = pd.read_excel(elec_file)
    #欄位數量 ((後8行
    n=data.shape[1]
    for i in range(2,n-8):
        data.iloc[0,i]=data.iloc[1,i]
    #dta_name={舊欄位名稱1:新欄位名稱1,舊欄位名稱2:新欄位名稱2,...}
    dta_name={}
    for i in range(0,n):
        dta_name[data.columns[i]]=data.iloc[0,i]
    new_data = data.rename(columns=dta_name) #重新命名欄位名稱
    #刪掉內容為NA的橫排
    new_data = new_data[5:]
    os.chdir("D:\\研究助理工作\\選舉資料\\選舉（各選區得票率）\\已整理\\歷年總統、副總統")
    os_path = os.getcwd()
    # 定義一個函數，將字串中的千分位逗號去除並轉換為數值
    def str_to_numeric(x):
        # 如果 x 是字串，且包含逗號，則去除逗號並轉換為數值
        if isinstance(x, str) and ',' in x:
            return pd.to_numeric(x.replace(',', ''), errors='coerce')
        # 如果 x 是字串，但不包含逗號，則檢查是否包含數字，如果有就轉換為數值
        elif isinstance(x, str) and re.search(r'\d', x):
            return pd.to_numeric(x, errors='coerce')
        # 如果 x 不是字串，或者是空值，則保持原樣
        else:
            return x

    # 將資料框中的所有元素應用上述函數，進行格式轉換
    new_data = new_data.applymap(str_to_numeric)
    folder_path = os.path.join(os_path,pj)
    if not os.path.exists(folder_path):
    # 如果目標資料夾不存在，則創建它
        os.makedirs(folder_path)
        
    savepath = os.path.join(os_path, pj, os.path.splitext(filename)[0] + ".xlsx")
    new_data.to_excel(savepath, index=False)
    return new_data

for i in os.listdir(path):
    if os.path.isdir(os.path.join(path,i))==True and "總統" in i: #i:立委、總統、縣市長資料夾
        #print(i)
        for j in os.listdir(i):
            #print(j) 
            if os.path.isdir(os.path.join(path,i,j))==True : #j:各屆選舉資料夾
                #print(j)
                num=0
                for file in os.listdir(os.path.join(path,i,j)): #file:選舉檔(xlsx,xls)
                    #print(file)
                    #if "平地" in file or "山地" in file: #排除原住民區立選舉
                    if (file.endswith(".xls")==True or file.endswith(".xlsx")==True) and "-2-" in file :
                        num+=1
                        file_path = os.path.join(path,i,j)
                        print(file_path, file)
                        #跑function
                        president(filename=file, fpath=file_path, pi=i, pj=j)

###########
#改檔名_立委
os.chdir("D:\\研究助理工作\\選舉資料\\選舉（各選區得票率）\\已整理\\歷年立委")
pathu = os.getcwd()
for j in os.listdir(pathu):
    k = os.listdir(j)
    for n in range(0,len(k)):
        if os.path.exists(f'./{j}/{n}.xlsx'):
            os.remove(f'./{j}/{n}.xlsx')
        elif os.path.exists(f'./{j}/{n}.dta'):
            os.remove(f'./{j}/{n}.dta')

for j in os.listdir(pathu):
    k = os.listdir(j)
    for n in range(0,len(k)):
        os.rename(f'./{j}/{k[n]}',f'./{j}/{n}.xlsx')
"""
data = pd.read_excel("D:\\研究助理工作\\選舉資料\\選舉（各選區得票率）\\已整理\\歷年直轄市、縣市長\\2022.11.26縣市長（各投票所得票明細及概況）\\嘉義市.xls")
savepath="D:\\研究助理工作\\選舉資料\\選舉（各選區得票率）\\已整理\\歷年直轄市、縣市長\\2022.11.26縣市長（各投票所得票明細及概況）\\嘉義市.xlsx"
data.to_excel(savepath, index=False)
os.rename(f'./{j}/{k}',f'./{j}/{new_fname}.xlsx')
"""

###########
#改檔名_縣市長
import os
os.chdir("D:\\研究助理工作\\選舉資料\\選舉（各選區得票率）\\已整理\\歷年直轄市、縣市長")
pathu = os.getcwd()
for j in os.listdir(pathu):
    for k in os.listdir(j):
        if "市" in k and "111年" not in k:
            a=k.rfind("市")
            new_fname = k[a-2:a+1]
        elif "縣" in k and "111年" not in k:
            a=k.rfind("縣")
            new_fname = k[a-2:a+1]
        elif "111年" in k:
            a=k.rfind("縣市")
            new_fname = k[a-3:a]
        os.rename(f'./{j}/{k}',f'./{j}/{new_fname}.xlsx')
    
for i in os.listdir(path):
    if os.path.isdir(os.path.join(path,i))==True and "縣市長" in i: #i:立委、總統、縣市長資料夾
        #print(i)
        for j in os.listdir(i):
            #print(j) 
            if os.path.isdir(os.path.join(path,i,j))==True: #j:各屆選舉資料夾
                #print(j)
                num=0
                for file in os.listdir(os.path.join(path,i,j)): #file:選舉檔(xlsx,xls)
                    #print(file)
"""
#改檔名
import os
os.chdir("C:/Users/user/Downloads")
path = os.getcwd()
a=os.listdir("農情資料")
os.mkdir('C:/Users/user/Downloads/農情資料夾')
for i in range(0,len(a)):
    os.rename(f'./農情資料/{a[i]}',f'./農情資料夾/{i}.csv')


for i in range(0,len(a)):
    os.rename(f'./農情資料/{a[i]}',f'./農情資料夾/{i}.csv')
    
    if "市" in filename:
        a=file.find("市")
        new_fname = file[a-2:a+1]
    elif "縣" in filename:
        a=file.find("縣")
        new_fname = file[a-2:a+1]
"""

os.chdir("D:\\研究助理工作\\選舉資料\\選舉（各選區得票率）\\已整理\\歷年立委")
pathu = os.getcwd()
l="2020.1"
k = os.listdir(l)
for n in range(0,len(k)):
    if "xlsx" in k[n]:
        print(k[n])
        elec_file = os.path.join(pathu,l,k[n])
        ddd = pd.read_excel(elec_file)
        print(ddd.iloc[0,0])
    
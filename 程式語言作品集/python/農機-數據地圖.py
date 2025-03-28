
import os
import pandas as pd
import geopandas as gpd
import matplotlib.pyplot as plt
import mapclassify as mc
import numpy as np

# 設置中文字型
plt.rcParams['font.sans-serif'] = ['Microsoft YaHei'] 

# 讀取農機資料
excel_file = 'D:\\研究助理工作\\農機\\農機0512.xlsx'
df = pd.read_excel(excel_file)
types=list(set(df["農機種類"]))

# 讀取鄉鎮市區邊界資料
town_shp_path = "D:\\台灣行政圖\\TOWN_MOI_1120825.shp"
town_shp = gpd.read_file(town_shp_path)

# 讀取縣市邊界資料
county_shp_path = "D:\\台灣行政圖\\COUNTY_MOI_1090820.shp"
county_shp = gpd.read_file(county_shp_path)

# 設置鄉鎮市區與縣市的對應關係
town_shp["county_town"] = town_shp["COUNTYNAME"] + town_shp["TOWNNAME"]

# 分地區
for i in ["地區"]:
    df_county = df.groupby(i).sum()
    df_county["area"] = df_county.index
    # 設置左邊的 GeoDataFrame，即鄉鎮市區
    left = town_shp.set_index("county_town")
    title_name = "鄉鎮市區"

    
    # 設置右邊的 GeoDataFrame，即農機資料
    right = df_county.set_index("area")
    
    # 將兩個 GeoDataFrame 合併
    data_merge = left.join(right)
    data_merge = data_merge.fillna(0)

    # 生成分類器
    classifier = mc.UserDefined(data_merge['次數'], bins=[0, 50, 100, 150, 200, 250, 310])
    data_merge['N_class'] = classifier.yb
    
    # 繪製地圖
    fig, ax = plt.subplots(figsize=(20, 20))
    data_merge.plot(ax=ax, column='N_class', cmap='Oranges', legend=False)
    
    # 繪製縣市邊界
    county_shp.plot(ax=ax, edgecolor='grey', linewidth=0.5, facecolor='none')
    
    # 添加圖例
    cmap = plt.cm.get_cmap('Oranges', len(classifier.bins))
    handles = [plt.Rectangle((0, 0), 1, 1, color=cmap(i)) for i in range(len(classifier.bins))]
    labels = [f'{int(classifier.bins[i])+1} - {int(classifier.bins[i+1])}' for i in range(len(classifier.bins) - 1)]
    labels.insert(0, f'{int(0)}')
    plt.legend(handles, labels, loc='lower right', fancybox=True, handlelength=1,title="農機分布數量", fontsize=14)
    
    # 設置地圖範圍和標題
    plt.title("農機分布地圖_"+title_name, fontsize=16)
    ax.set_xlim(118, 123)
    ax.set_ylim(21.5, 25.5)
    
    # 顯示圖形
    plt.show()
    # 保存圖片
    save_path = f'D:\\研究助理工作\\農機\\graph\\農機分布地圖_{title_name}.png'
    if os.path.exists(save_path):
        os.remove(save_path)  # 如果存在相同檔名的圖片，先刪除舊檔案
    plt.savefig(save_path)
    plt.close()  
    
#******************************************************************************************

for i in ["地區"]:
    df_county = df.groupby([i, "農機種類"]).sum().reset_index()
    df_county["area"] = df_county[i]
    df_county["type"] = df_county["農機種類"]
    # 設置左邊的 GeoDataFrame，即鄉鎮市區
    left = town_shp.set_index("county_town")
    title_name = "鄉鎮市區"
    
    for t in types:
        type_df = df_county[df_county["type"]==t]
        right = type_df.set_index("area")
        data_merge = left.join(right)
        data_merge = data_merge.fillna(0)
        
        # 設置分類區間
        if max(data_merge["次數"])<=160 and max(data_merge["次數"]>120):
            bin_range_=[0, 40, 80, 120, 160]
        elif max(data_merge["次數"])<=120 and max(data_merge["次數"]>100):
            bin_range_=[0, 30, 60, 90, 120]
        elif max(data_merge["次數"])<=100 and max(data_merge["次數"]>80):
            bin_range_=[0, 20, 40, 60, 80, 100]
        elif max(data_merge["次數"])<=80 and max(data_merge["次數"])>60:
            bin_range_=[0, 20, 40, 60, 80]
        elif max(data_merge["次數"])<=60 and max(data_merge["次數"])>50:
            bin_range_=[0, 15, 30, 45, 60]
        elif max(data_merge["次數"])<=50 and max(data_merge["次數"])>40:
            bin_range_=[0, 10, 20, 30, 40, 50]
        elif max(data_merge["次數"])<=40 and max(data_merge["次數"])>30:
            bin_range_=[0, 10, 20, 30, 40]
        elif max(data_merge["次數"])<=30 and max(data_merge["次數"])>25:
            bin_range_=[0, 5, 10, 15, 20, 25, 30]
        elif max(data_merge["次數"])<=25 and max(data_merge["次數"])>20:
            bin_range_=[0, 5, 10, 15, 20, 25]    
        elif max(data_merge["次數"])<=20 and max(data_merge["次數"])>15:
            bin_range_=[0, 5, 10, 15, 20]
        elif max(data_merge["次數"])<=15 and max(data_merge["次數"])>12:
            bin_range_=[0, 3, 6, 9, 12, 15]
        elif max(data_merge["次數"])<=12 and max(data_merge["次數"])>10:
            bin_range_=[0, 3, 6, 9, 12]
        elif max(data_merge["次數"])<=10 and max(data_merge["次數"])>8:
            bin_range_=[0, 2, 4, 6, 8, 10]
        elif max(data_merge["次數"])<=8 and max(data_merge["次數"])>6:
            bin_range_=[0, 2, 4, 6, 8]
        elif max(data_merge["次數"])==6:
            bin_range_=[0, 2, 4, 6]
        elif max(data_merge["次數"])<=5:
            bin_range_=np.arange(int(data_merge['次數'].min()), int(data_merge['次數'].max()) + 1, 1)
        
        # 生成分類器
        classifier = mc.UserDefined(data_merge['次數'], bins=bin_range_)
        data_merge['N_class'] = classifier.yb
        fig, ax = plt.subplots(figsize=(20, 20))
        # 繪製地圖
        data_merge.plot(ax=ax, column='N_class', cmap=cmap, legend=False)
        # 繪製各縣市的邊界
        county_shp.plot(ax=ax, edgecolor='grey', linewidth=0.5, facecolor='none')
        # 添加圖例
        cmap = plt.cm.get_cmap('Oranges', len(classifier.bins))
        handles = [plt.Rectangle((0, 0), 1, 1, color=cmap(i)) for i in range(len(classifier.bins))]
        labels = [f'{int(classifier.bins[i])+1} - {int(classifier.bins[i+1])}' for i in range(len(classifier.bins)-1)]
        labels.insert(0,f'{int(0)}')
        if max(data_merge["次數"])>int(labels[-1][labels[-1].rfind(" - ")+3:]):
            print(t)
            #break
        if max(data_merge["次數"])<6:
            labels = [f'{int(classifier.bins[i])}' for i in range(len(classifier.bins))]
        plt.legend(handles, labels, loc='lower right', fancybox=True, handlelength=1,title=t+"分布數量", fontsize=14)
        ymin, xmin = 21.5, 118
        ymax, xmax = 25.5, 123
        plt.title(t+"分布地圖_"+title_name, fontsize=16)
        ax.set_xlim(xmin, xmax)
        ax.set_ylim(ymin, ymax)

        # 保存圖片
        save_path = f'D:\\研究助理工作\\農機\\graph\\{t}分布地圖_{title_name}.png'
        if os.path.exists(save_path):
            os.remove(save_path)  # 如果存在相同檔名的圖片，先刪除舊檔案
        plt.savefig(save_path)
        plt.close()


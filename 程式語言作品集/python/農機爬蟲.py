#pip install -U selenium
import os
Path=os.path.join("C:\\","Users","user","chromedriver.exe")
import pandas as pd
from selenium import webdriver
from selenium.webdriver.common.by import By
import bs4
from selenium.webdriver.support.ui import Select
import time
url = "https://eoi.afa.gov.tw"
driver = webdriver.Chrome()
driver.implicitly_wait(100)
driver.get(url)
soup = bs4.BeautifulSoup(driver.page_source, "lxml")
excel = []
#22縣市
for i in range(1,23):
    for types in ["1020","2010","3010","4025","6010","6011","6014","6020","6030","6040","8140","A010","A050"]:
        time.sleep(1)
        select_major = Select(driver.find_element(By.ID,'QAreaID'))
        select_major.select_by_index(i)
        time.sleep(0.5)
        select_major = Select(driver.find_element(By.ID,'QAreaID'))
        select_major.select_by_index(i)
        time.sleep(1)
        select_type = Select(driver.find_element(By.ID,'QMachineID'))
        select_type.select_by_value(types)
        time.sleep(0.5)
        select_type = Select(driver.find_element(By.ID,'QMachineID'))
        select_type.select_by_value(types)
        time.sleep(1)
        driver.find_element(By.XPATH,"/html/body/div[2]/div/div[1]/form/div[7]/input[2]").click()
        soup_i = bs4.BeautifulSoup(driver.page_source, "lxml")

        if soup_i.select("tbody tr td")!=[]:
            if soup_i.select("tbody tr td")[0].text=="1":
                num=0
            elif soup_i.select("tbody tr td")[0].text=="←":
                num=20
        else:
            continue
        while num < len(soup_i.select("tbody tr td")):
            dict1={}
            dict1["項次"] = soup_i.select("tbody tr td")[num].text       
            dict1["地區"] = soup_i.select("tbody tr td")[num+1].text
            dict1["縣市"] = soup_i.select("tbody tr td")[num+1].text[0:3]
            dict1["鄉鎮市區"] = soup_i.select("tbody tr td")[num+1].text[3:]
            dict1["村里"] = soup_i.select("tbody tr td")[num+2].text
            dict1["農機種類"] = soup_i.select("tbody tr td")[num+3].text
            if (dict1["縣市"]=="彰化縣") or ((dict1["縣市"]=="雲林縣" or dict1["縣市"]=="臺南市") and dict1["農機種類"]=="曳引機"):
                break
            dict1["農機廠牌"] = soup_i.select("tbody tr td")[num+4].text
            dict1["動力大小"] = soup_i.select("tbody tr td")[num+5].text
            dict1["姓名"] = soup_i.select("tbody tr td")[num+6].text
            excel.append(dict1)
            num+=8

df = pd.DataFrame(data=excel)
df.to_excel("D:\\農機完整檔.xlsx", index=False)
#彰雲南曳引機
excel_n = []
for other in ["07","09","11"]:
    select_major = Select(driver.find_element(By.ID,'QAreaID'))
    select_major.select_by_value(other)
    time.sleep(1)
    select_major = Select(driver.find_element(By.ID,'QAreaID'))
    select_major.select_by_value(other)
    time.sleep(0.5)
    select_type = Select(driver.find_element(By.ID,'QMachineID'))
    select_type.select_by_value("1020")
    time.sleep(0.5)
    select_type = Select(driver.find_element(By.ID,'QMachineID'))
    select_type.select_by_value("1020")
    time.sleep(0.5)
    if other=="07":
        area=26
    elif other=="09":
        area=20
    elif other=="11":
        area=38
    for area_i in range(1,area+1):
        select_area = Select(driver.find_element(By.ID,'QTownID'))
        select_area.select_by_index(area_i)
        time.sleep(0.5)
        select_area = Select(driver.find_element(By.ID,'QTownID'))
        select_area.select_by_index(area_i)
        time.sleep(0.5)
        search_click=driver.find_element(By.XPATH,"/html/body/div[2]/div/div[1]/form/div[7]/input[2]")
        time.sleep(1)
        search_click.click()
        soup_i = bs4.BeautifulSoup(driver.page_source, "lxml")

        if soup_i.select("tbody tr td")!=[]:
            if soup_i.select("tbody tr td")[0].text=="1":
                num=0
            elif soup_i.select("tbody tr td")[0].text=="←":
                num=20
        else:
            continue
        while num < len(soup_i.select("tbody tr td")):
            dict1={}
            dict1["項次"] = soup_i.select("tbody tr td")[num].text       
            dict1["地區"] = soup_i.select("tbody tr td")[num+1].text
            dict1["縣市"] = soup_i.select("tbody tr td")[num+1].text[0:3]
            dict1["鄉鎮市區"] = soup_i.select("tbody tr td")[num+1].text[3:]
            dict1["村里"] = soup_i.select("tbody tr td")[num+2].text
            dict1["農機種類"] = soup_i.select("tbody tr td")[num+3].text
            dict1["農機廠牌"] = soup_i.select("tbody tr td")[num+4].text
            dict1["動力大小"] = soup_i.select("tbody tr td")[num+5].text
            dict1["姓名"] = soup_i.select("tbody tr td")[num+6].text
            excel_n.append(dict1)
            num+=8

dfa = pd.DataFrame(data=excel_n)
dfa.to_excel("D:\\農機_彰雲南曳引機.xlsx", index=False)

excel_ch=[]
for types in ["2010","3010","4025","6010","6011","6014","6020","6030","6040","8140","A010","A050"]:
    select_major = Select(driver.find_element(By.ID,'QAreaID'))
    select_major.select_by_value("07")
    time.sleep(0.5)
    select_major = Select(driver.find_element(By.ID,'QAreaID'))
    select_major.select_by_value("07")
    time.sleep(0.5)
    select_type = Select(driver.find_element(By.ID,'QMachineID'))
    select_type.select_by_value(types)
    time.sleep(0.5)
    select_type = Select(driver.find_element(By.ID,'QMachineID'))
    select_type.select_by_value(types)
    time.sleep(0.5)
    driver.find_element(By.XPATH,"/html/body/div[2]/div/div[1]/form/div[7]/input[2]").click()
    soup_i = bs4.BeautifulSoup(driver.page_source, "lxml")
    
    if soup_i.select("tbody tr td")!=[]:
        if soup_i.select("tbody tr td")[0].text=="1":
            num=0
        elif soup_i.select("tbody tr td")[0].text=="←":
            num=20
    else:
        continue
    while num < len(soup_i.select("tbody tr td")):
        dict1={}
        dict1["項次"] = soup_i.select("tbody tr td")[num].text       
        dict1["地區"] = soup_i.select("tbody tr td")[num+1].text
        dict1["縣市"] = soup_i.select("tbody tr td")[num+1].text[0:3]
        dict1["鄉鎮市區"] = soup_i.select("tbody tr td")[num+1].text[3:]
        dict1["村里"] = soup_i.select("tbody tr td")[num+2].text
        dict1["農機種類"] = soup_i.select("tbody tr td")[num+3].text
        dict1["農機廠牌"] = soup_i.select("tbody tr td")[num+4].text
        dict1["動力大小"] = soup_i.select("tbody tr td")[num+5].text
        dict1["姓名"] = soup_i.select("tbody tr td")[num+6].text
        excel_ch.append(dict1)
        num+=8
dfch = pd.DataFrame(data=excel_ch)
dfch.to_excel("D:\\農機_彰化.xlsx", index=False)
driver.close()
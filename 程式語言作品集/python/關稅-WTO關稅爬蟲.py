

import pandas as pd
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import bs4
from selenium.webdriver.support.ui import Select
import time

url = "https://tao.wto.org/ExportReport.aspx?RT=TL"
driver = webdriver.Chrome()
driver.implicitly_wait(100)
wait = WebDriverWait(driver, 20)
driver.get(url)
email_name = "XXXXXX@gmail.com"
password_name = "XXXXXXX"

def login():
    #輸入帳號
    email = driver.find_element(By.ID, "ctl00_c_ctrLogin_UserName")
    email.send_keys(email_name)
    
    #輸入密碼
    password = driver.find_element(By.ID, "ctl00_c_ctrLogin_Password")
    password.send_keys(password_name)
    
    #登入
    driver.find_element(By.ID, "ctl00_c_ctrLogin_RememberMe").click()
    driver.find_element(By.XPATH,"/html/body/form/a/table/tbody/tr[1]/td[2]/table/tbody/tr[2]/td/table/tbody/tr[2]/td/div/table/tbody/tr[3]/td/table/tbody/tr[1]/td[1]/table/tbody/tr/td/table/tbody/tr[5]/td/input").click()
    
    #出口面臨關稅
    while True:
        try:
            wait.until(EC.element_to_be_clickable((By.XPATH, "/html/body/form/table/tbody/tr[1]/td[2]/table/tbody/tr[2]/td/div/table/tbody/tr[2]/td[1]/table/tbody/tr[1]/td/table/tbody/tr/td[1]/a"))).click()
            time.sleep(3)
            print(0)
            while True:
                try:
                    wait.until(EC.element_to_be_clickable((By.XPATH, "/html/body/form/table/tbody/tr[1]/td[2]/table/tbody/tr[2]/td/div/table/tbody/tr[2]/td[2]/div/table/tbody/tr[3]/td/div/table/tbody/tr[6]/td"))).click()
                    print(0.1)
                    time.sleep(3)
                    break
                except:
                    print(1.1)
            break
        except:
            print(1)
    
    #start year
    while True:
        try:
            select_syear = Select(wait.until(EC.visibility_of_element_located((By.ID, 'ctl00_c_cboStartYear'))))
            select_syear.select_by_value("1996")
            break
        except:
            print(2)
    
    #exporter country
    while True:
        try:
            select_excountry = Select(wait.until(EC.visibility_of_element_located((By.ID, 'ctl00_c_cboExporter'))))
            select_excountry.select_by_value("C158") #Chinese Taipei
            break
        except:
            print(3)

login()
#importer country
country = {"美國":"C840", "日本":"C392", "中國":"C156", "歐盟":"U918", "韓國":"C410", "香港":"C344", "紐西蘭":"C554"}
for country_item in country.items():
    excel = []
    while True:
        try:        
            select_imcountry = Select(wait.until(EC.visibility_of_element_located((By.ID, 'ctl00_c_cboImporter'))))
            select_imcountry.select_by_value(country_item[1]) 
            break
        except:
            if driver.current_url != "https://tao.wto.org/report/ExportMarketV2.aspx":
                login()
            print(4)
    
    #貨品chapter
    code_list = list(range(1,77)) + list(range(78,98))
    for code in code_list:
        if code<10:
            code = "0"+str(code)
        else:
            code = str(code)
        while True:
            try:
                select_chapter = Select(driver.find_element(By.ID,'ctl00_c_cboChapter'))
                select_chapter.select_by_value(code)
                break
            except:
                if driver.current_url != "https://tao.wto.org/report/ExportMarketV2.aspx":
                    login()
                    while True:
                        try:        
                            select_imcountry = Select(wait.until(EC.visibility_of_element_located((By.ID, 'ctl00_c_cboImporter'))))
                            select_imcountry.select_by_value(country_item[1])
                            break
                        except:
                            print(5.4)
                print(5)
        #稅率Detail
        if code == "01":
            while True:
                try:
                    driver.find_element(By.ID, "ctl00_c_rbDetail").click()
                    select_chapter = Select(driver.find_element(By.ID,'ctl00_c_cboDetailLevel'))
                    select_chapter.select_by_value("TariffLine")
                    break
                except:
                    if driver.current_url != "https://tao.wto.org/report/ExportMarketV2.aspx":
                        login()
                        while True:
                            try:        
                                select_imcountry = Select(wait.until(EC.visibility_of_element_located((By.ID, 'ctl00_c_cboImporter'))))
                                select_imcountry.select_by_value(country_item[1]) 
                                break
                            except:
                                print(6.4)
                        while True:
                            try:
                                select_chapter = Select(driver.find_element(By.ID,'ctl00_c_cboChapter'))
                                select_chapter.select_by_value(code)
                                break
                            except:
                                print(6.5)
                    print(6)
        #查詢Display
        while True:
            try:
                driver.find_element(By.ID, "ctl00_c_cmdRunReport").click()
                time.sleep(2)
                print(7.0)
                break
            except:
                if driver.current_url == "https://tao.wto.org/welcome.aspx?ReturnUrl=%2fdefault.aspx":
                    login()
                    while True:
                        try:        
                            select_imcountry = Select(wait.until(EC.visibility_of_element_located((By.ID, 'ctl00_c_cboImporter'))))
                            select_imcountry.select_by_value(country_item[1]) 
                            break
                        except:
                            print(7.4)
                    while True:
                        try:
                            select_chapter = Select(driver.find_element(By.ID,'ctl00_c_cboChapter'))
                            select_chapter.select_by_value(code)
                            break
                        except:
                            print(7.5)
                    while True:
                        try:
                            driver.find_element(By.ID, "ctl00_c_rbDetail").click()
                            select_chapter = Select(driver.find_element(By.ID,'ctl00_c_cboDetailLevel'))
                            select_chapter.select_by_value("TariffLine")
                            break
                        except:
                            print(7.6)
                print(7)
                
        #抓資料..................................................
        locate = "html body form table tbody tr td div table tbody tr td div table tbody tr td div div div table tbody tr"
        while True:
            try:
                soup_i = bs4.BeautifulSoup(driver.page_source, "lxml")
                data = soup_i.select(locate)
                data[8].text.split('\n')[1]
            except:
                time.sleep(2)
                soup_i = bs4.BeautifulSoup(driver.page_source, "lxml")
                data = soup_i.select(locate)
                data[8].text.split('\n')[1]
            
        i = 6
        while i < len(data):
            print(i,len(data))
            dict1 = {}
            data_i = data[i].text.split('\n')
            if len(data_i)==9:
                dict1 = {
                    "TL_num" : data_i[1][:data_i[1].find(" ")], 
                    "外文貨名" : data_i[1][data_i[1].find(" ")+1:],
                    "年份" : "",
                    "金額(美元)" : data_i[2],
                    "Ad val." : data_i[3],
                    "Non ad val." : data_i[4],
                    "貿易協定" :data_i[5],
                    "貿易協定 Ad val." : data_i[6],
                    "貿易協定 Non ad val." : data_i[7]
                    }
            elif len(data_i)==10:
                dict1 = {
                    "TL_num" : data_i[1], 
                    "外文貨名" : data_i[1],
                    "年份" : data_i[2],
                    "金額(美元)" : data_i[3],
                    "Ad val." : data_i[4],
                    "Non ad val." : data_i[5],
                    "貿易協定" :data_i[6],
                    "貿易協定 Ad val." : data_i[7],
                    "貿易協定 Non ad val." : data_i[8]
                    }
            excel.append(dict1)
            i += 1
    
    dfch = pd.DataFrame(data=excel)
    dfch.to_excel(f"D:\\研究助理工作\\關稅\\出口關稅\\{country_item[0]}.xlsx", index=False)


driver.quit()



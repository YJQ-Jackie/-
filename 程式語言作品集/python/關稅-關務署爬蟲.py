
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import Select
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import pytesseract
from PIL import Image
import io
import pandas as pd
import time


data = pd.read_excel("D:\\研究助理工作\\關稅\\code_num2.xlsx", dtype={"code_num": str})
code_list = list(set(list(data["code_num"])))
code_list.sort()

url = "https://cuswebo.trade.gov.tw/FSC3000C?table=FSC3030F"
driver = webdriver.Chrome()
driver.implicitly_wait(100)
driver.get(url)

#驗證碼判讀
def get_captcha():
    while True:
        try:
            image_element = WebDriverWait(driver, 20).until(EC.presence_of_element_located((By.ID, 'verImg')))
            image_screenshot = image_element.screenshot_as_png #截圖
            image = Image.open(io.BytesIO(image_screenshot)) #讀取截圖
            image_text = pytesseract.image_to_string(image)
            image_text = image_text.strip()
            return image_text
            break
        except:
            driver.find_element(By.XPATH, "/html/body/div/div[3]/main/div/div[3]/div[2]/div[1]/div[1]/div[6]/div/button").click()


for code_num in code_list:
    print(code_num)
    print(code_list.index(code_num))
    #查詢貨號
    if driver.current_url != "https://cuswebo.trade.gov.tw/FSC3000C?table=FSC3030F":
        driver.back()
    while True:
        try:
            verification = driver.find_element(By.ID, "InputCode")
            code = driver.find_element(By.ID, "txtHS_CODE")
            code.clear()
            code.send_keys(str(code_num))
            break
        except:
            continue
    #驗證碼處理
    error_num = 1
    while error_num == 1:
        if driver.current_url!="https://cuswebo.trade.gov.tw/FSC3000C?table=FSC3030F":
            driver.back()
        error_num = 0
        verification.clear()
        image_text = get_captcha()
        if len(image_text) != 4: #重置
            error_num = 1
            WebDriverWait(driver, 5).until(
                EC.invisibility_of_element((By.CSS_SELECTOR, "div.loading"))
            )
            driver.find_element(By.XPATH, "/html/body/div/div[3]/main/div/div[3]/div[2]/div[1]/div[1]/div[6]/div/button").click()
            continue
        #輸入驗證碼
        verification.send_keys(image_text)
        time.sleep(1)
        code_error = driver.find_element(By.XPATH, "/html/body/div/div[3]/main/div/div[3]/div[2]/div[1]/div[1]/div[6]/div/div[2]/span")
        if code_error.text == "驗證碼輸入錯誤!" or code_error.text == "驗證碼逾時，請刷新!": #重置
            error_num = 1
            WebDriverWait(driver, 5).until(
                EC.invisibility_of_element((By.CSS_SELECTOR, "div.loading"))
            )
            driver.find_element(By.XPATH, "/html/body/div/div[3]/main/div/div[3]/div[2]/div[1]/div[1]/div[6]/div/button").click()
        else:
            break

    #查詢年分1989-2024
    select_syear = Select(driver.find_element(By.ID,'ddlYearS'))
    select_syear.select_by_value("1989")
    select_eyear = Select(driver.find_element(By.ID,'ddlYearE'))
    select_eyear.select_by_value("2024")

    
    
    #查詢
    try:
        WebDriverWait(driver, 5).until(
            EC.invisibility_of_element((By.CSS_SELECTOR, "div.loading"))
        )
        #查詢
        some_element = WebDriverWait(driver, 10).until(
            EC.element_to_be_clickable((By.XPATH, "/html/body/div/div[3]/main/div/div[3]/div[2]/div[1]/div[1]/div[8]/button[2]"))
            )
        some_element.click()
        if driver.current_url!="https://cuswebo.trade.gov.tw/FSC3000C?table=FSC3030F":
            driver.back()
            code_list.append(code_num)
            print("網頁跳轉")

    except  :
        while True:
            try:
                # 處理警告框
                alert = driver.switch_to.alert
                alert_text = alert.text
                print(f"處理警告框: {alert_text}")
        
                # 關閉警告框
                alert.accept()
                
                # 重新獲取並輸入正確的驗證碼
                driver.find_element(By.XPATH, "/html/body/div/div[3]/main/div/div[3]/div[2]/div[1]/div[1]/div[6]/div/button").click()
                verification.clear()
                verification.send_keys(get_captcha())
            
                # 重新進行嘗試
                some_element = WebDriverWait(driver, 10).until(
                    EC.element_to_be_clickable((By.XPATH, "/html/body/div/div[3]/main/div/div[3]/div[2]/div[1]/div[1]/div[8]/button[2]"))
                    )
                some_element.click()
                if driver.current_url!="https://cuswebo.trade.gov.tw/FSC3000C?table=FSC3030F":
                    driver.back()
                
            except :
                print("沒有發現警告框")
                driver.find_element(By.XPATH, "/html/body/div/div[3]/main/div/div[3]/div[2]/div[1]/div[1]/div[8]/button[2]").click()
                break
    #下載excel檔案
    driver.find_element(By.NAME, "EXCEL").click()
    driver.find_element(By.XPATH, "/html/body/div/div[3]/main/div/div[3]/div[2]/div[1]/div[1]/div[8]/button[1]").click()

driver.quit()



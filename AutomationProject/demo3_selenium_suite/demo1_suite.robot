*** Settings ***
Library     SeleniumLibrary

*** Test Cases ***
TC1 FB Login
    Open Browser    browser=chrome
    Go To    url=https://www.facebook.com/
    Click Element    xpath=(//span[text()='Allow all cookies'])[2]
    Input Text    id:email    bala2233fdf3343434@gmail.com
    Input Password    id=pass    welcome123
    #click on login
    Click Element  name=login

TC2
    Open Browser    browser=chrome
    Maximize Browser Window
    Set Selenium Implicit Wait    10s
    Go To    url=https://www.facebook.com/
    Click Element    xpath=(//span[text()='Allow all cookies'])[2]
    #click on create new account
    Click Element    link=Create new account
    #enter firstname as john
    Input Text    name=firstname    bala
    #enter lastname as dina
    Input Text    name=lastname    dina
    #password as welcome123
    Input Password    id=password_step_input    welcom123

    # 21 Dec 2000
    Select From List By Label    id=day     21
    Select From List By Label    id=month   Dec
    Select From List By Label    name=birthday_year     2000
     #click on custom radio button
    Click Element    xpath=//input[@value='-1']
    #automate year 2000

TC3 Multiple Tabs
    Open Browser    browser=chrome
    Maximize Browser Window
    Set Selenium Implicit Wait    5s
    Go To    url=https://www.db4free.net/
    #click on phpMyAdmin »
    Click Element    partial link=phpMyAdmi123
    Switch Window   phpMyAdmin
    Input Text    id=input_username    admin
    #enter password as test123
    [Teardown]      Close Browser

TC4 Frame
    Open Browser    browser=chrome
    Maximize Browser Window
    Set Selenium Implicit Wait    5s
    Go To    url=https://netbanking.hdfcbank.com/netbanking/
    Select Frame    xpath=//frame[@name='login_page']
    #enter userid as john123
    Input Text    name=fldLoginUserId    john123
    #click on continue
    Click Element    link=CONTINUE
    Unselect Frame
    [Teardown]  Close Browser

TC5 Alert
    Open Browser    browser=chrome
    Maximize Browser Window
    Set Selenium Implicit Wait    5s
    Go To    url=https://netbanking.hdfcbank.com/netbanking/IpinResetUsingOTP.htm
    Click Element    xpath=//img[@alt='Go']
    ${actual_alert_text}    Handle Alert    action=Accept   timeout=20s
    Log    ${actual_alert_text}
    Should Be Equal    ${actual_alert_text}    Customer ID${SPACE}${SPACE}cannot be left blank.

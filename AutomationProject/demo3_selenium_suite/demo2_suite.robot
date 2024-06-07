*** Settings ***
Library     SeleniumLibrary

Test Setup     Open Browser    browser=chrome
Test Teardown      Close Browser

*** Test Cases ***
TC1 FB Login

    Go To    url=https://www.facebook.com/
    Click Element    xpath=(//span[text()='Allow all cookies'])[2]
    Input Text    id:email    bala2233fdf3343434@gmail.com
    Input Password    id=pass    welcome123
    #click on login
    Click Element  name=login

TC2
    Maximize Browser Window
    Set Selenium Implicit Wait    10s
    Go To    url=https://www.facebook.com/
#    Click Element    xpath=(//span[text()='Allow all cookies'])[2]
    #click on create new account

TC3
    [Setup]     None
    Log To Console     hello
    [Teardown]      None
*** Settings ***
Library    DateTime
Library    String

*** Variables ***
${BROWSER_NAME}     chrome
@{COLORS}   red    green   yellow   blue
&{MY_DETAIL}    name=bala   role=trainer    mobile=2243344
&{HEADER}   Authorization=Bearer dfjdfndfndn    Content-Type=application/json

*** Test Cases ***
TC1
    Log To Console      Balaji Dinakaran
    Log To Console    Welcome to robot framework session
    Log To Console    message=Hi Everyone
    
TC2
    Log To Console    hi

T3
    ${my_name}     Set Variable    bala
    Log To Console    ${my_name}
    ${my_name}  Convert To Upper Case   ${my_name}
    Log To Console    ${my_name}
T4
    ${radius}=   Set Variable    10
    ${result}   Evaluate    3.14*${radius}*${radius}
    Log To Console    ${result}

TC5
    ${current_date}    Get Current Date
    Log To Console    ${current_date}

#write test case to check for leap year
#write test case to print odd or even number

TC6
    Log To Console    ${BROWSER_NAME}
    
TC7
    Log To Console    ${BROWSER_NAME}
    Log To Console    ${COLORS}
    Log To Console    ${COLORS}[2]
    Log To Console    ${MY_DETAIL}
    Log To Console    ${MY_DETAIL}[role]

 #create a dictionary &{HEADER} to keep Authorization, Content-Type=application/json
 
TC8
   &{header}  Create Dictionary      Authorization=Bearer dfjdfndfndn    Content-Type=application/json
   Log To Console    ${header}[Authorization]
   @{numbers}  Create List      23      334     3434
   Log To Console    ${numbers}
   Log To Console    ${numbers}[0]

TC9
    Log To Console    ${CURDIR}
    Log To Console    ${OUTPUT_DIR}
    Log To Console    ${EXECDIR}
    Log To Console    ${TEST_NAME}
    Log To Console    ${SUITE_NAME}
    Log To Console    ${EXECDIR}${/}files${/}add_pet.json
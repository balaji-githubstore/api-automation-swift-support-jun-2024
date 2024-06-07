*** Settings ***
Library    RequestsLibrary
Library    OperatingSystem

Suite Setup     Create Session    alias=petshop    url=https://petstore.swagger.io/v2/
Suite Teardown      Delete All Sessions

*** Test Cases ***
TC1 Add Valid Pet
    ${json}     Get Binary File     ${EXECDIR}${/}files${/}add_pet.json
    &{header}   Create Dictionary      Content-Type=application/json       Connection=keep-alive

    ${respone}    POST On Session     alias=petshop     url=pet     headers=${header}
    ...     data=${json}       expected_status=200

    Log    ${respone.json()}
    Should Be Equal As Numbers    ${respone.json()}[id]    201
    Should Be Equal As Strings    ${respone.json()}[name]    doggie-201
    
TC2 Delete Valid Pet
    ${respone}      DELETE On Session       alias=petshop       url=pet/201     expected_status=200
    Log    ${respone.json()}
    Should Be Equal As Strings    ${respone.json()}[message]    201

TC3 Delete Invalid Pet
    ${respone}      DELETE On Session       alias=petshop       url=pet/201     expected_status=404


TC4 Put Valid Pet
    ${json}     Get Binary File     ${EXECDIR}${/}files${/}new_pet.json
    &{header}   Create Dictionary      Content-Type=application/json       Connection=keep-alive

    ${respone}    Put On Session     alias=petshop     url=pet     headers=${header}
    ...     data=${json}       expected_status=200

    Log    ${respone.json()}
    Should Be Equal As Numbers    ${respone.json()}[id]    201

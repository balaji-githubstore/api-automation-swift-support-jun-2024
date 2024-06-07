*** Settings ***
Library    RequestsLibrary

*** Test Cases ***
TC1 Find Valid Pet
    Create Session    alias=petshop    url=https://petstore.swagger.io/v2/
    ${response}    GET On Session  alias=petshop   url=/pet/101     expected_status=200
    Log    ${response.json()}
    Log    ${response.json()}[id]
    Log    ${response.json()}[category]
    Log    ${response.json()}[status]

    Status Should Be    200
    Should Be Equal As Numbers    ${response.json()}[id]    101

TC2 Find Invalid Pet
    Create Session    alias=petshop    url=https://petstore.swagger.io/v2/
#    @{client certs}=  create list  ${cert_path}  ${key_path}
#    Create Client Cert Session  alias=${alias}  url=${url}  client_certs=${client certs}  verify=${False}
    ${response}    GET On Session  alias=petshop   url=/pet/101999      expected_status=404

TC3 Find Pet By Valid Status
    ${status}   Set Variable    sold
    Create Session    alias=petshop    url=https://petstore.swagger.io/v2/
    ${response}    GET On Session  alias=petshop   url=pet/findByStatus?status=${status}     expected_status=200
    Log    ${response.json()}


TC4 Find Pet By Valid Status And Verify the response
    ${status}   Set Variable    sold
    Create Session    alias=petshop    url=https://petstore.swagger.io/v2/
    ${response}    GET On Session  alias=petshop   url=pet/findByStatus?status=${status}     expected_status=200
    Log    ${response.json()}
#    Log    ${response.json()}[0]
#    Log    ${response.json()}[0][status]
    ${count}    Get Length    ${response.json()}

    FOR    ${i}    IN RANGE    0    ${count}
        Log    ${response.json()}[${i}][status]
        Should Be Equal As Strings    ${response.json()}[${i}][status]    ${status}
    END

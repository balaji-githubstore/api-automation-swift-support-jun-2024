*** Settings ***
Library    RequestsLibrary
Library    OperatingSystem
Library    String
Library     SeleniumLibrary

Suite Setup     Create Session    alias=github    url=https://api.github.com/
Suite Teardown      Delete All Sessions

*** Variables ***
${CLIENT_ID}      Ov23lizmv6HkDFDexGoi
${CLIENT_SECRET}  10d4dd71793408f81d01357cd07ff2c5ea273b5c
${AUTH_URL}       https://github.com/login/oauth/authorize
${TOKEN_URL}      https://github.com/login/oauth/access_token
${CALLBACK_URL}   https://oauth.pstmn.io/v1/browser-callback
${SCOPE}          repo
${CODE}           NA

*** Keywords ***
Get Access Token
    Create Session    github    ${AUTH_URL}
    ${auth_payload}=  Create Dictionary    client_id=${CLIENT_ID}    scope=${SCOPE}    redirect_uri=${CALLBACK_URL}
    ${response}=      GET On Session    github    ${AUTH_URL}    params=${auth_payload}
    #Redirect to url and provide github credential and authorize
    Open Browser    browser=chrome
    Set Selenium Implicit Wait    30s
    Go To    url=${response.url}
    Input Text    id=login_field    balaji-githubstore
#    Input Password    id=password    XXXXXXXXXXX
    Sleep    10s
    Click Element    name=commit

    ${current_url}    Get Location
    ${CODE}     Fetch From Right   ${current_url}   code=
    Log    ${CODE}
    #Auth code is stored ${CODE}

    #once authorize then we get the authcode
    # using authcode we can request and get access token
    ${token_payload}=  Create Dictionary    client_id=${CLIENT_ID}    client_secret=${CLIENT_SECRET}    code=${CODE}    redirect_uri=${CALLBACK_URL}
    ${token_headers}=  Create Dictionary    Accept=application/json
    ${token_response}=  POST On Session    github    ${TOKEN_URL}    data=${token_payload}    headers=${token_headers}
    [Return]    ${token_response.json()}[access_token]

*** Test Cases ***
TC1 Update Git Repo
    ${access_token}     Get Access Token
    ${json}     Get Binary File    ${EXECDIR}${/}files${/}update_git.json
    &{headers}      Create Dictionary   Content-Type=application/json      Authorization=Bearer ${access_token}

    ${response}     PATCH On Session    alias=github       url=repos/balaji-githubstore/api-automation-swift-support-jun-2024
    ...   data=${json}      headers=${headers}
    Log    ${response.json()}





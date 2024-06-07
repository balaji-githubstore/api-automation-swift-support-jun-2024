*** Settings ***
Documentation       This resource contains code for authorization and create session and
...     important keywords

Library     RequestsLibrary
Library    SeleniumLibrary
Library    String
Library    OperatingSystem

*** Variables ***
${USERNAME}     balaji-githubstore
${TOKEN}    XXXXX

${CLIENT_ID}      Ov23lizmv6HkDFDexGoi
${CLIENT_SECRET}  10d4dd71793408f81d01357cd07ff2c5ea273b5c
${AUTH_URL}       https://github.com/login/oauth/authorize
${TOKEN_URL}      https://github.com/login/oauth/access_token
${CALLBACK_URL}   https://oauth.pstmn.io/v1/browser-callback
${SCOPE}          repo
${CODE}           NA

*** Keywords ***
Create Session With Basic Auth
    @{auth}      Create List   ${USERNAME}     ${TOKEN}
    Create Session    alias=github    url=https://api.github.com/       auth=${auth}

Create Session And Get Bearer Token
    Create Session    alias=github    url=https://api.github.com/
    Return From Keyword    ${TOKEN}

Create Session And Get OAuth Token
    Create Session    github    ${AUTH_URL}
    ${auth_payload}=  Create Dictionary    client_id=${CLIENT_ID}    scope=${SCOPE}    redirect_uri=${CALLBACK_URL}
    ${response}=      GET On Session    github    ${AUTH_URL}    params=${auth_payload}
    #Redirect to url and provide github credential and authorize
    Open Browser    browser=headlesschrome
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
    Return From Keyword    ${token_response.json()}[access_token]

Create Session For Petshop
    Create Session    alias=petshop    url=https://petstore.swagger.io/v2/
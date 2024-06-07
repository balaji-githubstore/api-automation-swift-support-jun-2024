*** Settings ***
Library    RequestsLibrary
Library    OperatingSystem
Library    String

Suite Setup     Create Session    alias=github    url=https://api.github.com/
Suite Teardown      Delete All Sessions


*** Keywords ***
Create Session With Basic Auth
    @{auth}      Create List   balaji-githubstore    XXXXXX
    Create Session    alias=github    url=https://api.github.com/       auth=${auth}

*** Test Cases ***
TC1 List public repositories
    ${response}     GET On Session  alias=github    url=repositories
    Log    ${response.json()}
#    Convert To List
    ${count}    Get Length    ${response.json()}
    FOR    ${i}    IN RANGE    0    ${count}
       Log    ${response.json()}[${i}][html_url]
    END

#Using Bearer token
TC2 Update Git Repo
    ${json}     Get Binary File    ${EXECDIR}${/}files${/}update_git.json

    &{headers}      Create Dictionary   Content-Type=application/json      Authorization=Bearer XXXXX

    ${response}     PATCH On Session    alias=github       url=repos/balaji-githubstore/api-automation-swift-support-jun-2024
    ...   data=${json}      headers=${headers}
    Log    ${response.json()}

#Using Basic auth token
TC3 Update Git Repo
    @{auth}      Create List   balaji-githubstore    XXXX
    Create Session    alias=github    url=https://api.github.com/       auth=${auth}

    ${json}     Get Binary File    ${EXECDIR}${/}files${/}update_git.json
    &{headers}      Create Dictionary   Content-Type=application/json

    ${response}     PATCH On Session    alias=github       url=repos/balaji-githubstore/api-automation-swift-support-jun-2024
    ...   data=${json}      headers=${headers}
    Log    ${response.json()}


TC4 Basic Auth
    Create Session With Basic Auth
      ${json}     Get Binary File    ${EXECDIR}${/}files${/}update_git.json
    &{headers}      Create Dictionary   Content-Type=application/json

    ${response}     PATCH On Session    alias=github       url=repos/balaji-githubstore/api-automation-swift-support-jun-2024
    ...   data=${json}      headers=${headers}
    Log    ${response.json()}



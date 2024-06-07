*** Settings ***
Documentation       This suite consist of all test case related to get pet by id

Resource    ../resources/base/CommonFunctionality.resource

#Suite Setup     Create Session With Basic Auth
Suite Teardown      Delete All Sessions

Test Template       Verify Pet By Id Template

Library    OperatingSystem

*** Test Cases ***

TC3 With Bearer Token
    [Template]  None
    ${token}        Create Session And Get Bearer Token
    ${json}     Get Binary File    ${EXECDIR}${/}files${/}update_git.json
    &{headers}      Create Dictionary   Content-Type=application/json      Authorization=Bearer ${token}
    ${response}     PATCH On Session    alias=github       url=repos/balaji-githubstore/api-automation-swift-support-jun-2024
    ...   data=${json}      headers=${headers}
    Log    ${response.json()}


*** Keywords ***
Verify Pet By Id Template
    [Arguments]     ${pet_id}   ${expected_status}
    ${response}    GET On Session  alias=petshop   url=/pet/${pet_id}     expected_status=${expected_status}
    Log    ${response.json()}
    Status Should Be    ${expected_status}
    IF    ${expected_status} == 200
         Should Be Equal As Numbers    ${response.json()}[id]    ${pet_id}
    END



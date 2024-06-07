*** Settings ***
Documentation       This suite consist of all test case related to get pet by id

Resource    ../resources/base/CommonFunctionality.resource

Suite Setup     Create Session For Petshop
Suite Teardown      Delete All Sessions

Library     DataDriver      file=../test_data/pet_id.csv

Test Template       Verify Pet By Id Template


*** Test Cases ***
TC1_${test_name}


*** Keywords ***
Verify Pet By Id Template
    [Arguments]     ${pet_id}   ${expected_status}
    ${response}    GET On Session  alias=petshop   url=/pet/${pet_id}     expected_status=${expected_status}
    Log    ${response.json()}
    Status Should Be    ${expected_status}
    IF    ${expected_status} == 200
         Should Be Equal As Numbers    ${response.json()}[id]    ${pet_id}
    END



*** Settings ***
Documentation    A test suite containing tests related to registration.
Resource         ../../resources/register.resource
Suite Setup      Open Browser To Registration Page
Suite Teardown   Close Browser
Test Setup       Go To Registration Page
Test Template    Register With Invalid Credentials Should Fail

*** Test Cases ***               ACCOUNT NUMBER    PASSWORD    FIRST NAME    LAST NAME    EXPECTED
Invalid Account Number           123456xxxx        1234        Kraiwitch     Pawadee      Please put accountId only number
Short Account Number             123456789         1234        Kraiwitch     Pawadee      Please fill accountId 10 digits
Long Account Number              12345678901       1234        Kraiwitch     Pawadee      Please fill accountId 10 digits
Existing Account Number          1234567890        1234        Kraiwitch     Pawadee      Account ID already existed
Short Password                   1234567890        123         Kraiwitch     Pawadee      Please fill password 4 digits
Long Password                    1234567890        12345       Kraiwitch     Pawadee      Please fill password 4 digits
Invalid Password                 1234567890        xxxx        Kraiwitch     Pawadee      Please put password only number
Long name                        1234567891        1235        aaaaaaaaaaaaaaaaaaaaaaaaaa    aaaaa     your name length is exceed 30 digits

*** Keywords ***
 Register With Invalid Credentials Should Fail
    [Arguments]    ${account_number}    ${password}    ${first_name}    ${last_name}    ${expected}
    Input Account Number        ${account_number}
    Input Password              ${password}
    Input First Name            ${first_name}
    Input Last Name             ${last_name}
    Submit Registration
    Wait Until Element Is Visible    ${MESSAGE_LOCATOR}
    Registration Should Have    ${expected}

Registration Should Have
    [Arguments]    ${expected}
    ${message}=    Get Registration Message
    Should Be Equal    ${message}    ${expected}
*** Settings ***
Documentation    A test suite containing tests related to invalid login.
Resource         ../../resources/common.resource
Resource         ../../resources/login.resource
Suite Setup      Open Browser To Login Page
Suite Teardown   Close Browser
Test Setup       Go To Login Page
Test Template    Login With Invalid Credentials Should Fail

*** Test Cases ***               USER NAME        PASSWORD         EXPECTED
Invalid Account Number           123456xxxx        1234            Please put accountId only number
Short Account Number             123456789         1234            Please fill accountId 10 digits
Long Account Number              12345678901       1234            Please fill accountId 10 digits
User Not Exist                   1234567895        1234            Not Found User
Short Password                   1234567890        123             Please fill password 4 digits
Long Password                    1234567890        12345           Please fill password 4 digits
Invalid Password                 1234567890        1235            Password Incorrect
Password Not Number              1234567890        xxxx            Please put password only number

*** Keywords ***
 Login With Invalid Credentials Should Fail
    [Arguments]    ${account_number}    ${password}    ${expected}
    Input Account Number        ${account_number}
    Input Password              ${password}
    Submit Credentials
    Wait Until Element Is Visible      ${MESSAGE_LOCATOR}
    Registration Should Have    ${expected}

Registration Should Have
    [Arguments]    ${expected}
    ${message}=    Get Login Message
    Should Be Equal    ${message}    ${expected}
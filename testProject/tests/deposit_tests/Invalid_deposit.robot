*** Settings ***
Documentation    A test suite containing tests related to Deposit Function.
Resource         ../../resources/account.resource
Resource         ../../resources/login.resource
Suite Setup      Run Keywords    Login    AND    Account Page Should Be Open
Suite Teardown   Close Browser
Test Setup       Go To Account Page
Test Template    Deposit With Invalid Value Should Fail

*** Test Cases ***               AMOUNT        EXPECTED
Deposit With Invalid Value(0)       0          Please put only number
Deposit With Invalid Value(-1)     -1          Please put only number


*** Keywords ***
Deposit With Invalid Value Should Fail
    [Arguments]        ${amount}     ${expected}
    Input Deposit Amount             ${amount}
    Confirm Deposit
    Wait Until Element Is Visible    ${DEPOSIT_MESSAGE_LOCATOR}
    Error Message Should Have         ${expected}

Error Message Should Have
    [Arguments]    ${expected}
    ${message}=    Get Deposit Message
    Should Be Equal    ${message}    ${expected}
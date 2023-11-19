*** Settings ***
Documentation    A test suite containing tests for invalid Withdraw Function.
Resource         ../../resources/account.resource
Resource         ../../resources/login.resource
Suite Setup      Run Keywords    Login    AND    Account Page Should Be Open    AND    Set Balance To    5000
Suite Teardown   Close Browser
Test Setup       Go To Account Page    
Test Template    Withdraw With Invalid Value Should Fail

*** Test Cases ***               AMOUNT        EXPECTED
Withdraw With Invalid Value(0)       0          Please put only number
Withdraw With Invalid Value(-1)     -1          Please put only number
Withdraw Exceed Balance            5001         your balance isn't not enough


*** Keywords ***
Withdraw With Invalid Value Should Fail
    [Arguments]        ${amount}     ${expected}
    Input Withdraw Amount             ${amount}
    Confirm Withdraw
    Wait Until Element Is Visible    ${WITHDRAW_MESSAGE_LOCATOR}
    Error message Should Be         ${expected}

Error message Should Be
    [Arguments]    ${expected}
    ${message}=    Get Withdraw Message
    Should Be Equal    ${message}    ${expected}
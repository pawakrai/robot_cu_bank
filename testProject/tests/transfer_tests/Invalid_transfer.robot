*** Settings ***
Documentation    A test suite containing tests for invalid Transfer Function.
Resource         ../../resources/account.resource
Resource         ../../resources/login.resource
Suite Setup      Run Keywords    Login    AND    Account Page Should Be Open    AND    Set Balance To    5000
Suite Teardown   Close Browser
Test Setup       Go To Account Page    
Test Template    Transfer With Invalid Value Should Fail

*** Test Cases ***                      TARGET_ACCOUNT               AMOUNT        EXPECTED
Target Account Not A Number             1234567xxx                      500         Please put accountId only number
Short Target Account                    123456789                       500         Please fill accountId 10 digits
Long Target Account                     12345678901                     500         Please fill accountId 10 digits
Not Exist Target Account                1234567899                      500         Not found your target account Id
Submit Your Account Number              1234567890                      500         Cannot transfer to your own id
Transfer With Invalid Amount(0)         ${VALID_TARGET_ACCOUNT}           0         Please put only number
Transfer With Invalid Amount(-1)        ${VALID_TARGET_ACCOUNT}          -1         Please put only number
Transfer With Invalid Amount(5001)      ${VALID_TARGET_ACCOUNT}        5001         your balance isn't not enough

*** Keywords ***
Transfer With Invalid Value Should Fail
    [Arguments]                        ${target_account}      ${amount}     ${expected}
    Input Target Account ID            ${target_account}
    Input Transfer Amount              ${amount}
    Confirm Transfer
    Wait Until Element Is Visible      ${TRANSFER_MESSAGE_LOCATOR}
    Error message Should Be            ${expected}

Error message Should Be
    [Arguments]        ${expected}
    ${message}=        Get Transfer Message
    Should Be Equal    ${message}    ${expected}
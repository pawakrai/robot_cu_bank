*** Settings ***
Documentation    A test suite containing tests for valid withdraw function.
Resource         ../../resources/account.resource
Resource         ../../resources/login.resource
Suite Setup      Run Keywords    Login    AND    Account Page Should Be Open
Suite Teardown   Close Browser
Test Setup       Run Keywords    Go To Account Page    AND    Set Balance To    5000
Test Template    Transfer With Valid Value

*** Test Cases ***                      TARGET_ACCOUNT                AMOUNT
Valid Transfer Amount Value(1)          ${VALID_TARGET_ACCOUNT}            1
Valid Transfer Amount Value(500)        ${VALID_TARGET_ACCOUNT}          500
Valid Transfer Amount Value(4999)       ${VALID_TARGET_ACCOUNT}         4999


*** Keywords ***
Transfer With Valid Value
    [Arguments]                      ${target_account}            ${amount}
    ${current_balance}=              Get Balance
    ${current_balance}=              Convert To Number    ${current_balance}
    Input Target Account ID          ${target_account}
    Input Transfer Amount            ${amount}
    Confirm Transfer
    Wait Until Element Is Visible    ${BALANCE_LOCATOR}
    Balance Should Be                ${current_balance - ${amount}}
    
*** Settings ***
Documentation    A test suite containing tests for valid withdraw function.
Resource         ../../resources/account.resource
Resource         ../../resources/login.resource
Suite Setup      Run Keywords    Login    AND    Account Page Should Be Open
Suite Teardown   Close Browser
Test Setup       Run Keywords    Go To Account Page    AND    Set Balance To    5000
Test Template    Withdraw With Valid Value

*** Test Cases ***                      AMOUNT
Valid Withdraw Amount Value(1)               1
Valid Withdraw Amount Value(4999)         4999


*** Keywords ***
Withdraw With Valid Value
    [Arguments]                 ${amount}
    ${current_balance}=         Get Balance
    ${current_balance}=         Convert To Number    ${current_balance}
    Input Withdraw Amount       ${amount}
    Confirm Withdraw
    Wait Until Element Is Visible     ${BALANCE_LOCATOR}
    Balance Should Be           ${current_balance - ${amount}}
    
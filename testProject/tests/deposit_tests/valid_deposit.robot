*** Settings ***
Documentation    A test suite with tests for valid Deopsit function.
Resource         ../../resources/account.resource
Resource         ../../resources/login.resource
Suite Setup      Run Keywords    Login    AND    Account Page Should Be Open
Suite Teardown   Close Browser
Test Setup       Run Keywords    Go To Account Page    AND    Set Balance To    0
Test Template    Deposit With Valid Value

*** Test Cases ***                      AMOUNT
Valid Deposit Amount Value(1)               1
Valid Deposit Amount Value(2)               2
Valid Deposit Amount Value(5000)         5000


*** Keywords ***
Deposit With Valid Value
    [Arguments]                 ${amount}
    Input Deposit Amount        ${amount}
    Confirm Deposit
    Balance Should Be           ${amount}
    
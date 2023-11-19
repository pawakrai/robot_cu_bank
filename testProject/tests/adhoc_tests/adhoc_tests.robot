*** Settings ***
Documentation        A test suite containing adhoc tests for All function.
Resource             ../../resources/account.resource
Resource             ../../resources/login.resource
Resource             ../../resources/register.resource
Suite Setup          Open Browser To Login Page
Suite Teardown       Close Browser

*** Test Cases ***
# Deposit
Deposit Max Safe Interger Value
    [Documentation]    Deposit Safe Interger Value
    [Tags]    Deposit
    Login with    ${VALID_USER}    ${VALID_PASSWORD}
    Set Balance To Zero
    Deposit     9007199254740991
    Balance Should Be    9007199254740991
    Logout

Deposit Exceed Max Value (max +)
    [Documentation]    Deposit Exceed Max Value
    [Tags]    Deposit
    Login with    ${VALID_USER}    ${VALID_PASSWORD}
    Set Balance To Zero
    Deposit      9007199254740993
    Balance Should Equal    9007199254740993
    Logout

Deposit Exceed Max Value (max ++)
    [Documentation]    Deposit Exceed Max Value
    [Tags]    Deposit
    Login with    ${VALID_USER}    ${VALID_PASSWORD}
    Set Balance To Zero
    Deposit      900719925474099267
    Balance Should Equal    900719925474099267
    Logout

# Withdraw
Withdraw Exceed Max Value (max +)
    [Documentation]    Withdraw Exceed Max Value
    [Tags]    Withdraw
    Login with    ${VALID_USER}    ${VALID_PASSWORD}
    Set Balance To Zero
    Deposit      900719925474099267
    Withdraw     900719925474099315
    Withdraw Error Message Should Have    your balance isn't not enough
    Logout

*** Keywords ***
Withdraw Error Message Should Have
    [Arguments]    ${expected}
    ${message}=    Get Withdraw Message
    Should Be Equal    ${message}    ${expected}
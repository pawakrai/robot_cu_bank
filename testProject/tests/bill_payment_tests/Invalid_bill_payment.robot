*** Settings ***
Documentation    A test suite containing tests for invalid Bill Payment Function.
Resource         ../../resources/account.resource
Resource         ../../resources/login.resource
Suite Setup      Run Keywords    Login    AND    Account Page Should Be Open    AND    Set Balance To    5000
Suite Teardown   Close Browser
Test Setup       Go To Account Page    
Test Template    Bill Payment With Invalid Value Should Fail

*** Test Cases ***                                  SELECTED_BILL_TYPE               AMOUNT        EXPECTED
Water Bill Payment With Invalid Amount(0)            Water                                0         Please put only number
Water Bill Payment With Invalid Amount(-1)           Water                               -1         Please put only number
Water Bill Payment With Invalid Amount(5001)         Water                             5001         your balance isn't not enough
Electric Bill Payment With Invalid Amount(0)         Electric                             0         Please put only number
Electric Bill Payment With Invalid Amount(-1)        Electric                            -1         Please put only number
Electric Bill Payment With Invalid Amount(5001)      Electric                          5001         your balance isn't not enough
Phone Bill Payment With Invalid Amount(0)            Phone                                0         Please put only number
Phone Bill Payment With Invalid Amount(-1)           Phone                               -1         Please put only number
Phone Bill Payment With Invalid Amount(5001)         Phone                             5001         your balance isn't not enough

*** Keywords ***
Bill Payment With Invalid Value Should Fail
    [Arguments]                        ${selected_bill_type}      ${amount}     ${expected}
    Select Bill Type                   ${selected_bill_type}
    Input Bill Pay Amount              ${amount}
    Confirm Bill Pay
    Wait Until Element Is Visible      ${BILL_PAY_MESSAGE_LOCATOR}
    Error message Should Be            ${expected}

Error message Should Be
    [Arguments]        ${expected}
    ${message}=        Get Bill Pay Message
    Should Be Equal    ${message}    ${expected}
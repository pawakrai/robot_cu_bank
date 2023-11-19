*** Settings ***
Documentation    A test suite containing tests for valid Bill payment function.
Resource         ../../resources/account.resource
Resource         ../../resources/login.resource
Suite Setup      Run Keywords    Login    AND    Account Page Should Be Open
Suite Teardown   Close Browser
Test Setup       Run Keywords    Go To Account Page    AND    Set Balance To    5000
Test Template    Bill Pay With Valid Value

*** Test Cases ***                              SELECTED_BILL_TYPE            AMOUNT
# Water Bill Pay With Valid Value
Valid Water Bill Pay Amount Value(1)                  Water                        1
Valid Water Bill Pay Amount Value(500)                Water                      500
Valid Water Bill Pay Amount Value(4999)               Water                     4999

# Electricity Bill Pay With Valid Value
Valid Electric Bill Pay Amount Value(1)            Electric                         1
Valid Electric Bill Pay Amount Value(500)          Electric                       500
Valid Electric Bill Pay Amount Value(4999)         Electric                      4999

# Phone Bill Pay With Valid Value
Valid Phone Bill Pay Amount Value(1)                  Phone                        1
Valid Phone Bill Pay Amount Value(500)                Phone                      500
Valid Phone Bill Pay Amount Value(4999)               Phone                     4999

*** Keywords ***
Bill Pay With Valid Value
    [Arguments]                      ${selected_bill_type}            ${amount}
    ${current_balance}=              Get Balance
    ${current_balance}=              Convert To Number    ${current_balance}
    Select Bill Type                 bill_type=${selected_bill_type}
    Input Bill Pay Amount            ${amount}
    Confirm Bill Pay
    Wait Until Element Is Visible    ${BALANCE_LOCATOR}
    Balance Should Be                ${current_balance - ${amount}}
    
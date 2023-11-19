*** Settings ***
Documentation    A test suite with a single test for valid register.
Resource         ../../resources/register.resource
Suite Setup      Open Browser To Registration Page
Suite Teardown   Close Browser
Test Setup       Go To Registration Page
Test Template    Register With Credentials

*** Test Cases ***            ACCOUNT NUMBER    PASSWORD    FIRST NAME    LAST NAME
Valid Registration            1234567898        1234        Kraiwitch     Pawadee
Valid Name                    1234567899        1235        aaaaaaaaaaaaaaaaaaaaaaaa     aaaaa

*** Keywords ***
Register With Credentials
    [Arguments]    ${account_number}    ${password}    ${first_name}    ${last_name}
    Input Account Number        ${account_number}
    Input Password              ${password}
    Input First Name            ${first_name}
    Input Last Name             ${last_name}
    Submit Registration
    Alert Should Be Present    success
*** Settings ***
Documentation     A test suite with a single test for valid login.

...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../../resources/login.resource
Suite Setup      Open Browser To Login Page
Suite Teardown   Close Browser
Test Setup       Go To Login Page
Test Template    Register With Credentials

*** Test Cases ***            ACCOUNT NUMBER    PASSWORD
Valid Registration            1234567890        1234

*** Keywords ***
Register With Credentials
    [Arguments]    ${account_number}    ${password}
    Input Account Number        ${account_number}
    Input Password              ${password}
    Submit Credentials
    Should Go to Account Page

Should Go to Account Page
    Wait Until Page Contains    Account
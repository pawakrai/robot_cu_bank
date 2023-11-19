*** Settings ***
Documentation    Login Resource File
Resource         ./common.resource
Resource         ./account.resource

*** Variables ***
# Login Page Locators
${LOGIN_TITLE}               Login
${LOGIN_TITLE_LOCATOR}       //div[@id='root']/div/div/div/h2
${ACCOUNT_NUMBER_LOCATOR}    //input[@id='accountId']
${PASSWORD_LOCATOR}          //input[@id='password']
${BUTTON_LOCATOR}            //div[@id='root']/div/div/div/form/button
${MESSAGE_LOCATOR}           //div[@id='root']/div/div/div/form/label[2]/div/label
${LOGOUT_LOCATOR}            //div[@id='root']/div/nav/div/a[2]

# Test Data


*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Login Page Should Be Open

Login Page Should Be Open
    Wait Until Element Contains    ${LOGIN_TITLE_LOCATOR}    ${LOGIN_TITLE}

Go To Login Page
    Go To    ${LOGIN_URL}
    Login Page Should Be Open

Login with
    [Arguments]    ${username}    ${password}
    Go To Login Page
    Input Account Number    ${username}
    Input Password    ${password}
    Submit Credentials

Logout
    Account Page Should Be Open
    Click Element     ${LOGOUT_LOCATOR}

Login
    Open Browser To Login Page
    Input Account Number    ${VALID_USER}
    Input Password    ${VALID_PASSWORD}
    Submit Credentials

Input Account Number
    [Arguments]    ${username}
    Input Text    ${ACCOUNT_NUMBER_LOCATOR}    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    ${PASSWORD_LOCATOR}    ${password}

Submit Credentials
    Click Button    ${BUTTON_LOCATOR}

Get Login Message
    ${message}=    Get Text    ${MESSAGE_LOCATOR}
    [Return]    ${message}
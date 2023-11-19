*** Settings ***
Documentation    Register Resource
Resource         ./common.resource

*** Variables ***
# Locators
${ACCOUNT_NUMBER_LOCATOR}    //input[@id='accountId']
${PASSWORD_LOCATOR}          //input[@id='password']
${FIRST_NAME_LOCATOR}        //input[@id='firstName']
${LAST_NAME_LOCATOR}         //input[@id='lastName']
${SUBMIT_BUTTON_LOCATOR}     //div[@id='root']/div/div/div/form/button
${MESSAGE_LOCATOR}           //div[@id='root']/div/div/div/form/div/label
${REGISTER_HEADER_LOCATOR}   //div[@id='root']/div/div/div/h2

*** Keywords ***
Open Browser To Registration Page
    Open Browser    ${REGISTRATION_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Register Page Should Be Open

Register Page Should Be Open
    Wait Until Element Contains    ${REGISTER_HEADER_LOCATOR}    Register

Go To Registration Page
    Go To    ${REGISTRATION_URL}
    Register Page Should Be Open

Input Account Number
    [Arguments]    ${account_number}
    Input Text    ${ACCOUNT_NUMBER_LOCATOR}    ${account_number}

Input Password
    [Arguments]    ${password}
    Input Text    ${PASSWORD_LOCATOR}    ${password}

Input First Name
    [Arguments]    ${first_name}
    Input Text    ${FIRST_NAME_LOCATOR}    ${first_name}

Input Last Name
    [Arguments]    ${last_name}
    Input Text    ${LAST_NAME_LOCATOR}    ${last_name}

Submit Registration
    Click Button    ${SUBMIT_BUTTON_LOCATOR}

Get Registration Message
    ${message}=    Get Text    ${MESSAGE_LOCATOR}
    [Return]    ${message}
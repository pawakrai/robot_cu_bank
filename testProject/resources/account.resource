*** Settings ***
Documentation    Deposit Resource
Resource         ./common.resource

*** Variables ***
# Locators
# Account Page
${HEADER_LOCATOR}                //div[@id='root']/div/div/div/div[2]/article/h2    
${BALANCE_LOCATOR}               //div[@id='root']/div/div/div/div[2]/article/h1[3]

# Deposit Block
${HEADER_DEPOSIT_LOCATOR}        //div[@id='root']/div/div/div/div[3]/div/h2
${DEPOSIT_AMOUNT_LOCATOR}        //input[@cid='d1']
${DEPOSIT_BUTTON_LOCATOR}        //button[@cid='dc']
${DEPOSIT_MESSAGE_LOCATOR}       //div[@id='root']/div/div/div/div[3]/div[2]/form/div/label

# Withdraw Block
${HEADER_WIDTHDRAW_LOCATOR}       //div[@id='root']/div/div/div/div[4]/div/h2
${WITHDRAW_AMOUNT_LOCATOR}        //input[@cid='w1']
${WITHDRAW_BUTTON_LOCATOR}        //button[@cid='wc']
${WITHDRAW_MESSAGE_LOCATOR}       //div[@id='root']/div/div/div/div[4]/div[2]/form/div/label

# Transfer Block
${HEADER_TRANSFER_LOCATOR}        //div[@id='root']/div/div/div/div[5]/div/h2
${TARGET_ACCOUNT_LOCATOR}         //input[@id='accountId']
${TRANSFER_AMOUNT_LOCATOR}        //input[@cid='t2']
${TRANSFER_BUTTON_LOCATOR}        //button[@cid='tc']
${TRANSFER_MESSAGE_LOCATOR}       //div[@id='root']/div/div/div/div[5]/div[2]/form/div[3]/label

# Bill Pay Block
${HEADER_BILL_PAY_LOCATOR}        //div[@id='root']/div/div/div/div[6]/div/h2
${WATER_CHARGE_LOCATOR}           //input[@name='billTarget']
${ELECTRIC_CHARGE_LOCATOR}        (//input[@name='billTarget'])[2]
${PHONE_CHARGE_LOCATOR}           (//input[@name='billTarget'])[3]
${BILL_PAY_AMOUNT_LOCATOR}        //input[@cid='b4']
${BILL_PAY_MESSAGE_LOCATOR}       //div[@id='root']/div/div/div/div[6]/div[2]/form/div[3]/label
${BILL_PAY_CONFIRM_LOCATOR}       //button[@cid='bc']

# Variables
${VALID_TARGET_ACCOUNT}           1234567891
${ZERO}                           0

*** Keywords ***
Open Browser To Account Page
    Open Browser    ${ACCOUNT_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Account Page Should Be Open

Account Page Should Be Open
    Wait Until Element Contains    ${HEADER_LOCATOR}    Account
    Location Should Be    ${ACCOUNT_URL}

Go To Account Page
    Go To    ${Account_URL}
    Account Page Should Be Open

Get Balance
    ${balance}=    Get Text    ${BALANCE_LOCATOR}
    [Return]    ${balance}

Set Balance To Zero
    Wait Until Element Is Visible    ${BALANCE_LOCATOR}
    ${current_balance}=    Get Balance
    Run Keyword If    ${current_balance} > ${ZERO}    withdraw     ${current_balance}

Set Balance To
    [Arguments]    ${balance}
    Wait Until Element Is Visible    ${BALANCE_LOCATOR}
    ${current_balance}=    Get Balance
    ${current_balance}=    Convert To Number    ${current_balance}
    ${balance}=    Convert To Number    ${balance}
    Run Keyword If    ${current_balance} > ${balance}    Withdraw    ${current_balance - ${balance}} 
    Run Keyword If    ${current_balance} < ${balance}    Deposit     ${balance - ${current_balance}}
    Balance Should Be    ${balance}

Balance Should Be
    [Arguments]    ${expected_balance}
    Wait Until Element Is Visible    ${BALANCE_LOCATOR}
    ${expected_balance}=    Convert To Number    ${expected_balance}
    Wait Until Keyword Succeeds    10x    1s    Balance Has Changed    ${expected_balance}
    ${current_balance}=    Get Balance
    ${current_balance}=    Convert To Number    ${current_balance}
    Should Be Equal As Numbers    ${current_balance}    ${expected_balance}

Balance Should Equal
    [Arguments]    ${expected_balance}
    Wait Until Element Is Visible    ${BALANCE_LOCATOR}
    ${current_balance}=    Get Balance
    Should Be Equal    ${current_balance}    ${expected_balance}

Balance Has Changed
    [Arguments]    ${expected_balance}
    ${current_balance}=    Get Balance
    ${current_balance}=    Convert To Number    ${current_balance}
    Should Be Equal As Numbers    ${current_balance}    ${expected_balance}

# Deposit Block
Deposit Block Should Be Visible
    Wait Until Element Contains    ${HEADER_DEPOSIT_LOCATOR}    Deposit
    Wait Until Element Is Visible    ${DEPOSIT_AMOUNT_LOCATOR}
    Wait Until Element Is Visible    ${DEPOSIT_BUTTON_LOCATOR}

Input Deposit Amount
    [Arguments]    ${amount}
    Input Text    ${DEPOSIT_AMOUNT_LOCATOR}    ${amount}

Confirm Deposit
    Click Button    ${DEPOSIT_BUTTON_LOCATOR}

Deposit
    [Arguments]    ${amount}
    Deposit Block Should Be Visible
    Input Deposit Amount    ${amount}
    Confirm Deposit

Get Deposit Message
    ${message}=    Get Text    ${DEPOSIT_MESSAGE_LOCATOR}
    [Return]    ${message}

# Withdraw Block
Withdraw Block Should Be Visible
    Wait Until Element Contains    ${HEADER_WIDTHDRAW_LOCATOR}    Withdraw
    Wait Until Element Is Visible    ${WITHDRAW_AMOUNT_LOCATOR}
    Wait Until Element Is Visible    ${WITHDRAW_BUTTON_LOCATOR}

Input Withdraw Amount
    [Arguments]    ${amount}
    Input Text    ${WITHDRAW_AMOUNT_LOCATOR}    ${amount}

Confirm Withdraw
    Click Button    ${WITHDRAW_BUTTON_LOCATOR}

Withdraw
    [Arguments]    ${amount}
    Withdraw Block Should Be Visible
    Input Withdraw Amount    ${amount}
    Confirm Withdraw

Get Withdraw Message
    Withdraw Block Should Be Visible
    ${message}=    Get Text    ${WITHDRAW_MESSAGE_LOCATOR}
    [Return]    ${message}

# Transfer Block
Transfer Block Should Be Visible
    Wait Until Element Contains    ${HEADER_TRANSFER_LOCATOR}    Transfer
    Wait Until Element Is Visible    ${TRANSFER_AMOUNT_LOCATOR}
    Wait Until Element Is Visible    ${TRANSFER_BUTTON_LOCATOR}

Input Target Account ID
    [Arguments]    ${account}
    Input Text    ${TARGET_ACCOUNT_LOCATOR}    ${account}

Input Transfer Amount
    [Arguments]    ${amount}
    Input Text    ${TRANSFER_AMOUNT_LOCATOR}    ${amount}

Confirm Transfer
    Click Button    ${TRANSFER_BUTTON_LOCATOR}

Transfer
    [Arguments]    ${account}    ${amount}
    Input Target Account ID    ${account}
    Input Transfer Amount    ${amount}
    Confirm Transfer

Get Transfer Message
    Transfer Block Should Be Visible
    ${message}=    Get Text    ${TRANSFER_MESSAGE_LOCATOR}
    [Return]    ${message}

# Bill Pay Block
Bill Pay Block Should Be Visible
    Wait Until Element Contains    ${HEADER_BILL_PAY_LOCATOR}    Bill Pay
    Wait Until Element Is Visible    ${WATER_CHARGE_LOCATOR}
    Wait Until Element Is Visible    ${ELECTRIC_CHARGE_LOCATOR}
    Wait Until Element Is Visible    ${PHONE_CHARGE_LOCATOR}
    Wait Until Element Is Visible    ${BILL_PAY_AMOUNT_LOCATOR}
    Wait Until Element Is Visible    ${BILL_PAY_CONFIRM_LOCATOR}

Select Water Charge
    Click Element    ${WATER_CHARGE_LOCATOR}

Select Electric Charge
    Click Element    ${ELECTRIC_CHARGE_LOCATOR}

Select Phone Charge
    Click Element    ${PHONE_CHARGE_LOCATOR}

Select Bill Type
    [Arguments]    ${bill_type}
    Run Keyword If    '${bill_type}' == 'Water'        Select Water Charge
    Run Keyword If    '${bill_type}' == 'Electric'     Select Electric Charge
    Run Keyword If    '${bill_type}' == 'Phone'        Select Phone Charge

Input Bill Pay Amount
    [Arguments]    ${amount}
    Input Text    ${BILL_PAY_AMOUNT_LOCATOR}    ${amount}

Bill Pay
    [Arguments]    ${amount}
    Bill Pay Block Should Be Visible
    Select Water Charge
    Input Bill Pay Amount    ${amount}
    Click Button    ${BILL_PAY_CONFIRM_LOCATOR}

Get Bill Pay Message
    Bill Pay Block Should Be Visible
    ${message}=    Get Text    ${BILL_PAY_MESSAGE_LOCATOR}
    [Return]    ${message}

Confirm Bill Pay
    Click Button    ${BILL_PAY_CONFIRM_LOCATOR}


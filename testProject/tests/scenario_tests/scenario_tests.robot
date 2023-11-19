*** Settings ***
Documentation        A test suite containing scenario tests for All function.
Resource             ../../resources/account.resource
Resource             ../../resources/login.resource
Resource             ../../resources/register.resource
Suite Setup          Open Browser To Login Page
Suite Teardown       Close Browser

*** Test Cases ***
# TC2
Senario 1
    [Documentation]    ทดสอบกรณีการลงทะเบียน แบบไม่ผ่าน
    [Tags]    SC1    Smoke    Regression
    Go To Registration Page
    register.Input Account Number    123456xxxx
    register.Input Password          ${VALID_PASSWORD}
    Input First Name                 ${VALID_FIRST_NAME}
    Input Last Name                  ${VALID_LAST_NAME}

# TC15
Senario 2
    [Documentation]    ทดสอบการ login ที่ไม่ผ่าน
    [Tags]    SC2    Smoke    Regression
    Go To Login Page
    Login with    ${INVALID_USER}    ${VALID_PASSWORD}

# TC13, TC23
Senario 3
    [Documentation]    ทดสอบการ login ที่ผ่านตามด้วยการฝากเงินที่ไม่ผ่าน
    [Tags]    SC3    Smoke    Regression
    Login with    ${VALID_USER}    ${VALID_PASSWORD}
    Deposit    amount=0
    Deposit Error Message Should Have     Please put only number 
    Logout

# TC13, TC26, TC38
Senario 4
    [Documentation]    ทดสอบการ login ที่ผ่าน ตามด้วยการฝากเงินที่ผ่าน และถอนเงินที่ไม่ผ่าน (เงินในบัญชีไม่พอ)
    [Tags]    SC4    Smoke    Regression
    Login with    ${VALID_USER}    ${VALID_PASSWORD}
    Set Balance To    0
    Deposit    amount=5000
    Balance Should Be           5000
    Withdraw    amount=5001
    Withdraw Error Message Should Have     your balance isn't not enough
    Logout

# TC13, TC26, TC35, TC43
Senario 5
    [Documentation]    ทดสอบการ login ที่ผ่าน ตามด้วยการฝากเงินที่ผ่าน ถอนเงินที่ผ่าน และตามด้วยการโอนเงินที่ไม่ผ่าน (เช่นใส่เลขที่บัญชีที่จะรับเงินโอนผิด)
    [Tags]    SC5    Smoke    Regression
    Login with    ${VALID_USER}    ${VALID_PASSWORD}
    Set Balance To    0
    Deposit    amount=5000
    Balance Should Be           5000
    Withdraw    amount=500
    Balance Should Be           4500
    Transfer   account=9234567891  amount=500 
    Transfer Error Message Should Have     Not found your target account Id
    Logout

# TC13, TC59
Senario 6
    [Documentation]    ทดสอบการ login ที่ผ่าน ตามด้วยการจ่ายบิลที่ไม่ผ่าน
    [Tags]    SC6    Smoke    Regression
    Login with    ${VALID_USER}    ${VALID_PASSWORD}
    Bill Pay    amount=0
    Bill Pay Error Message Should Have     Please put only number
    Logout

# TC13, TC55
Senario 7
    [Documentation]    ทดสอบการ login ที่ผ่าน ตามด้วยการจ่ายบิลที่ผ่าน
    [Tags]    SC7    Smoke    Regression
    Login with    ${VALID_USER}    ${VALID_PASSWORD}
    Set Balance To            5000
    Bill Pay            amount=500
    Balance Should Be         4500
    Logout

# TC13, TC26, TC32
Senario 8
    [Documentation]    ทดสอบการ login ที่ผ่าน ตามด้วยการฝากเงินที่ผ่าน และถอนเงินที่ไม่ผ่าน (ใส่จำนวนเงินเท่ากับ 0)
    [Tags]    SC8    Smoke    Regression
    Login with    ${VALID_USER}    ${VALID_PASSWORD}
    Set Balance To    0
    Deposit    amount=5000
    Balance Should Be           5000
    Withdraw    amount=0
    Withdraw Error Message Should Have     Please put only number
    Logout

# TC13, TC26, TC35, TC46
Senario 9
    [Documentation]    ทดสอบการ login ที่ผ่าน ตามด้วยการฝากเงินที่ผ่าน ถอนเงินที่ผ่าน และตามด้วยการโอนเงินที่ไม่ผ่าน (ใส่จำนวนเงินเท่ากับ 0)
    [Tags]    SC9    Smoke    Regression
    Login with    ${VALID_USER}    ${VALID_PASSWORD}
    Set Balance To    0
    Deposit    amount=5000
    Balance Should Be           5000
    Withdraw    amount=500
    Balance Should Be           4500
    Transfer   account=1234567891  amount=0 
    Transfer Error Message Should Have     Please put only number
    Logout

# TC13, TC26, TC35, TC49, TC59
Senario 10
    [Documentation]    ทดสอบการ login ที่ผ่าน ตามด้วยการฝากเงินที่ผ่าน ถอนเงินที่ผ่าน โอนเงินที่ผ่าน และตามด้วยการจ่ายบิลที่ไม่ผ่าน(ใส่จำนวนเงินเท่ากับ 0)
    [Tags]    SC10    Smoke    Regression
    Login with    ${VALID_USER}    ${VALID_PASSWORD}
    Set Balance To    0
    Deposit    amount=5000
    Balance Should Be           5000
    Withdraw    amount=500
    Balance Should Be           4500
    Transfer   account=1234567891  amount=500
    Balance Should Be           4000 
    Bill Pay    amount=0
    Bill Pay Error Message Should Have     Please put only number
    Logout

# TC13, TC26, TC35, TC49, TC64
Senario 11
    [Documentation]    ทดสอบการ login ที่ผ่าน ตามด้วยการฝากเงินที่ผ่าน ถอนเงินที่ผ่าน โอนเงินที่ผ่าน และตามด้วยการจ่ายบิลที่ไม่ผ่าน(เงินในบัญชีไม่พอ)
    [Tags]    SC11    Smoke    Regression
    Login with    ${VALID_USER}    ${VALID_PASSWORD}
    Set Balance To    0
    Deposit    amount=5000
    Balance Should Be           5000
    Withdraw    amount=500
    Balance Should Be           4500
    Transfer   account=1234567891  amount=500
    Balance Should Be           4000 
    Bill Pay    amount=5001
    Bill Pay Error Message Should Have     your balance isn't not enough
    Logout

# TC13, TC26, TC35, TC49, TC55
Senario 12
    [Documentation]    ทดสอบการ login ที่ผ่าน ตามด้วยการฝากเงินที่ผ่าน ถอนเงินที่ผ่าน โอนเงินที่ผ่าน และตามด้วยการจ่ายบิลที่ผ่าน
    [Tags]    SC12    Smoke    Regression
    Login with    ${VALID_USER}    ${VALID_PASSWORD}
    Set Balance To    0
    Deposit    amount=5000
    Balance Should Be           5000
    Withdraw    amount=500
    Balance Should Be           4500
    Transfer   account=1234567891  amount=500
    Balance Should Be           4000 
    Bill Pay    amount=500
    Balance Should Be           3500
    Logout

*** Keywords ***
Deposit Error Message Should Have
    [Arguments]    ${expected}
    ${message}=    Get Deposit Message
    Should Be Equal    ${message}    ${expected}

Withdraw Error Message Should Have
    [Arguments]    ${expected}
    ${message}=    Get Withdraw Message
    Should Be Equal    ${message}    ${expected}

Transfer Error Message Should Have
    [Arguments]    ${expected}
    ${message}=    Get Transfer Message
    Should Be Equal    ${message}    ${expected}

Bill Pay Error Message Should Have
    [Arguments]    ${expected}
    ${message}=    Get Bill Pay Message
    Should Be Equal    ${message}    ${expected}
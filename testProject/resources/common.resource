*** Settings ***   
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
# Browser
${SERVER}              localhost:3000
${BROWSER}             Chrome
${DELAY}               0
${LOGIN_URL}           http://${SERVER}/
${REGISTRATION_URL}    http://${SERVER}/register
${ACCOUNT_URL}         http://${SERVER}/account/

# Account
${VALID_USER}              1234567890
${VALID_PASSWORD}          1234
${INVALID_USER}            123456xxxx
${INVALID_PASSWORD}        12345
${VALID_PASSWORD}          1234
${VALID_FIRST_NAME}        Kraiwitch
${VALID_LAST_NAME}         Pawadee

*** Keywords ***

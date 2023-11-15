*** Settings ***
Documentation    A test suite for testing some core regression tests for AI Chat App 'IndividuAI'.
Library    SeleniumLibrary

*** Variables ***
${HOME PAGE}      http://localhost:3000/sign-in?redirect_url=http%3A%2F%2Flocalhost%3A3000%2F
${BROWSER}        Firefox
${USERNAME}       <youremail>
${PASSWORD}       <yourpassword>
${PRODUCT}        Echo Dot

*** Test Cases ***
User Login
    Open Browser To Login Page
    Input Username    ${USERNAME}
    Input Password    ${PASSWORD}
    #Submit Credentials
    Verify Login Success
    [Teardown]    Close Browser

Checkout Flow
    Open Browser To Login Page
    Input Username    ${USERNAME}
    Input Password    ${PASSWORD}
    Verify Login Success
    Click Upgrade Button
    #Verify The Payment Gateway
    [Teardown]    Close Browser

Verify Default Personas
    Open Browser To Login Page
    Input Username    ${USERNAME}
    Input Password    ${PASSWORD}
    #Submit Credentials
    Verify Login Success
    Verify Finance Personas
    Verify Technology Personas
    Verify Business Personas
    [Teardown]    Close Browser


*** Keywords ***
Open Browser To Login Page
    Open Browser    ${HOME PAGE}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    xpath=/html/body/div[1]/div/div/div[1]/h1    timeout=10s
    Page Should Contain    Sign in

Input Username
    [Arguments]    ${username}
    Click Element    xpath=/html/body/div[1]/div/div/div[2]/div[1]/button
    Wait Until Element Is Visible    xpath=//*[@id="identifierId"]
    Input Text    xpath=//*[@id="identifierId"]    ${username}
    ${button_xpath}=    Set Variable    //*[@id="identifierNext"]/div/button/div[3]
    ${click_script}=    Set Variable    var xpathResult = document.evaluate('${button_xpath}', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null); if (xpathResult.singleNodeValue) { xpathResult.singleNodeValue.click(); } else { throw new Error('Element not found'); }
    Execute JavaScript    ${click_script}

Input Password
    [Arguments]    ${password}
    Wait Until Element Is Visible    xpath=//*[@id="password"]/div[1]/div/div[1]/input    timeout=10s
    Input Text    xpath=//*[@id="password"]/div[1]/div/div[1]/input   ${password}
    Press Keys    xpath=//*[@id="password"]/div[1]/div/div[1]/input    ENTER

Submit Credentials
    Wait Until Element Is Visible    xpath=//*[@id="passwordNext"]/div/button/div[3]    timeout=10s
    #${button_xpath}=    Set Variable    xpath=//*[@id="passwordNext"]/div/button/div[3]
    #${click_script}=    Set Variable    var xpathResult = document.evaluate('${button_xpath}', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null); if (xpathResult.singleNodeValue) { xpathResult.singleNodeValue.click(); } else { throw new Error('Element not found'); }
    #Execute JavaScript    ${click_script}

Verify Login Success
    Wait Until Element Is Visible    xpath=/html/body/div[1]/div[1]/div[2]/button[1]    timeout=10s

Click Upgrade button
    Sleep    5s
    Click Element    xpath=/html/body/div[1]/div[1]/div[2]/button[1]
    Sleep    5s
    Press Keys    ${NONE}    \\13
    #Click Element    xpath=/html/body/div[6]/div[3]/button

Verify The Payment Gateway
    Wait Until Element Is Visible    xpath=/html/body/div[1]/div/div/footer/div[1]/a/span    timeout=10s

Verify Finance Personas
    Click Element    xpath=/html/body/div[1]/main/div/div[2]/button[3]
    Sleep    3s
    Page Should Contain    Jim
    Page Should Contain    Warren

Verify Technology Personas
    Click Element    xpath=/html/body/div[1]/main/div/div[2]/button[4]
    Sleep    3s
    Page Should Contain    Sundar
    Page Should Contain    Elon

Verify Business Personas
    Click Element    xpath=/html/body/div[1]/main/div/div[2]/button[5]
    Sleep    3s
    Page Should Contain    Mukesh
    Page Should Contain    Gautam



*** Settings ***
Library    Browser


*** Variables ***
${BASE_URL}             https://kennethchuaqiyang.github.io/demo-login-portal/
${USER_TYPE_SELECT}     css=[data-testid="user-type-select"]
${USERNAME_INPUT}       css=[data-testid="username-input"]
${PASSWORD_RADIO}       css=[data-testid="auth-method-password"]
${PASSCODE_RADIO}       css=[data-testid="auth-method-passcode"]
${CREDENTIAL_INPUT}     css=[data-testid="credential-input"]
${LOGIN_BUTTON}         css=[data-testid="login-button"]
${ERROR_MESSAGE}        css=[data-testid="error-message"]
${LOGOUT_BUTTON}    css=[data-testid="logout-button"]


*** Keywords ***
Open Login Page
    New Page    ${BASE_URL}

Ensure On Login Page
    ${count}=    Get Element Count    ${LOGOUT_BUTTON}
    IF    ${count} > 0
        Click    ${LOGOUT_BUTTON}
        Wait For Elements State    ${USER_TYPE_SELECT}    visible
    END
    
Select User Type
    [Arguments]    ${user_type}
    Select Options By    ${USER_TYPE_SELECT}    value    ${user_type}

Use Auth Method
    [Arguments]    ${method}
    IF    '${method}' == 'passcode'
        Check Checkbox    ${PASSCODE_RADIO}
    ELSE
        Check Checkbox    ${PASSWORD_RADIO}
    END

Login
    [Arguments]    ${user_type}    ${username}    ${credential}    ${method}=password
    Select User Type    ${user_type}
    Fill Text    ${USERNAME_INPUT}    ${username}
    Use Auth Method    ${method}
    Fill Text    ${CREDENTIAL_INPUT}    ${credential}
    Click    ${LOGIN_BUTTON}

Get Error Text
    ${text}=    Get Text    ${ERROR_MESSAGE}
    RETURN    ${text}

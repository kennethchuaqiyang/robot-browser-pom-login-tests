*** Settings ***
Library    Browser


*** Variables ***
${ADMIN_PAGE}       css=[data-testid="admin-page"]
${ADMIN_IMAGE}      css=[data-testid="admin-image"]
${LOGGED_IN_AS}     css=[data-testid="logged-in-as"]
${LOGOUT_BUTTON}    css=[data-testid="logout-button"]


*** Keywords ***
Go To Admin Page
    New Page    https://kennethchuaqiyang.github.io/demo-login-portal/admin.html

Logout From Admin
    Click    ${LOGOUT_BUTTON}

Get Logged In As Text
    ${text}=    Get Text    ${LOGGED_IN_AS}
    RETURN    ${text}
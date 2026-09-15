*** Settings ***
Library     Browser
Resource    ../resources/LoginPage.resource
Resource    ../resources/AdminPage.resource
Resource    ../resources/ShopPage.resource

Suite Setup       New Browser    chromium    headless=True
Suite Teardown    Close Browser
Test Setup        Open Login Page


*** Test Cases ***
# --- Admin - password ---
Admin Logs In With Correct Password
    [Template]    Admin Password Login Should Succeed
    admin1    Admin@123
    admin2    Admin@456

Admin - No Username, Correct Password
    Login    admin    ${EMPTY}    Admin@123    password
    ${error}=    Get Error Text
    Should Contain    ${error}    Enter a username

Admin - Invalid Username, Correct Password
    Login    admin    not-an-admin    Admin@123    password
    ${error}=    Get Error Text
    Should Contain    ${error}    No admin account

Admin - Valid Username, No Password
    Login    admin    admin1    ${EMPTY}    password
    ${error}=    Get Error Text
    Should Contain    ${error}    Enter a username

Admin - Valid Username, Wrong Password
    Login    admin    admin1    WrongPass123    password
    ${error}=    Get Error Text
    Should Contain    ${error}    Incorrect password

# --- Admin - passcode ---
Admin Logs In With Correct Passcode
    [Template]    Admin Passcode Login Should Succeed
    admin1    111111
    admin2    222222

Admin - No Username, Correct Passcode
    Login    admin    ${EMPTY}    111111    passcode
    ${error}=    Get Error Text
    Should Contain    ${error}    Enter a username

Admin - Invalid Username, Correct Passcode
    Login    admin    not-an-admin    111111    passcode
    ${error}=    Get Error Text
    Should Contain    ${error}    No admin account

Admin - Valid Username, No Passcode
    Login    admin    admin1    ${EMPTY}    passcode
    ${error}=    Get Error Text
    Should Contain    ${error}    Enter a username

Admin - Valid Username, Wrong Passcode
    Login    admin    admin1    999999    passcode
    ${error}=    Get Error Text
    Should Contain    ${error}    Incorrect passcode

# --- Customer - password ---
Customer Logs In With Correct Password
    [Template]    Customer Password Login Should Succeed
    customer1    Cust@123
    customer2    Cust@456

Customer - No Username, Correct Password
    Login    customer    ${EMPTY}    Cust@123    password
    ${error}=    Get Error Text
    Should Contain    ${error}    Enter a username

Customer - Invalid Username, Correct Password
    Login    customer    not-a-customer    Cust@123    password
    ${error}=    Get Error Text
    Should Contain    ${error}    No customer account

Customer - Valid Username, No Password
    Login    customer    customer1    ${EMPTY}    password
    ${error}=    Get Error Text
    Should Contain    ${error}    Enter a username

Customer - Valid Username, Wrong Password
    Login    customer    customer1    WrongPass123    password
    ${error}=    Get Error Text
    Should Contain    ${error}    Incorrect password

# --- Customer - passcode ---
Customer Logs In With Correct Passcode
    [Template]    Customer Passcode Login Should Succeed
    customer1    333333
    customer2    444444

Customer - No Username, Correct Passcode
    Login    customer    ${EMPTY}    333333    passcode
    ${error}=    Get Error Text
    Should Contain    ${error}    Enter a username

Customer - Invalid Username, Correct Passcode
    Login    customer    not-a-customer    333333    passcode
    ${error}=    Get Error Text
    Should Contain    ${error}    No customer account

Customer - Valid Username, No Passcode
    Login    customer    customer1    ${EMPTY}    passcode
    ${error}=    Get Error Text
    Should Contain    ${error}    Enter a username

Customer - Valid Username, Wrong Passcode
    Login    customer    customer1    999999    passcode
    ${error}=    Get Error Text
    Should Contain    ${error}    Incorrect passcode


*** Keywords ***
Admin Password Login Should Succeed
    [Arguments]    ${username}    ${password}
    Ensure On Login Page
    Login    admin    ${username}    ${password}    password
    Get Url    contains    admin.html
    Wait For Elements State    ${ADMIN_PAGE}    visible
    Wait For Elements State    ${ADMIN_IMAGE}    visible
    ${text}=    Get Logged In As Text
    Should Contain    ${text}    ${username}

Admin Passcode Login Should Succeed
    [Arguments]    ${username}    ${passcode}
    Ensure On Login Page
    Login    admin    ${username}    ${passcode}    passcode
    Get Url    contains    admin.html
    Wait For Elements State    ${ADMIN_PAGE}    visible
    Wait For Elements State    ${ADMIN_IMAGE}    visible
    ${text}=    Get Logged In As Text
    Should Contain    ${text}    ${username}

Customer Password Login Should Succeed
    [Arguments]    ${username}    ${password}
    Ensure On Login Page
    Login    customer    ${username}    ${password}    password
    Get Url    contains    shop.html
    Wait For Elements State    ${SHOP_PAGE}    visible
    Wait For Elements State    ${PRODUCT_GRID}    visible
    ${text}=    Get Logged In As Text
    Should Contain    ${text}    ${username}

Customer Passcode Login Should Succeed
    [Arguments]    ${username}    ${passcode}
    Ensure On Login Page
    Login    customer    ${username}    ${passcode}    passcode
    Get Url    contains    shop.html
    Wait For Elements State    ${SHOP_PAGE}    visible
    Wait For Elements State    ${PRODUCT_GRID}    visible
    ${text}=    Get Logged In As Text
    Should Contain    ${text}    ${username}
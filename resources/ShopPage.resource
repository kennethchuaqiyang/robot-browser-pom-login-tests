*** Settings ***
Library    Browser


*** Variables ***
${SHOP_PAGE}        css=[data-testid="shop-page"]
${PRODUCT_GRID}     css=[data-testid="product-grid"]
${CART_NOTE}        css=[data-testid="cart-note"]
${LOGGED_IN_AS}      css=[data-testid="logged-in-as"]
${LOGOUT_BUTTON}    css=[data-testid="logout-button"]


*** Keywords ***
Go To Shop Page
    New Page    https://kennethchuaqiyang.github.io/demo-login-portal/shop.html

Add Product To Cart
    [Arguments]    ${product_id}
    Click    css=[data-testid="add-to-cart-${product_id}"]

Get Cart Note Text
    ${text}=    Get Text    ${CART_NOTE}
    RETURN    ${text}

Logout From Shop
    Click    ${LOGOUT_BUTTON}
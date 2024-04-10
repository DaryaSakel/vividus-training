Meta:
    @group Training
    @requirementId MyTask-0006

Lifecycle:
Examples:
|userName               |password    |
|standard_user          |secret_sauce|
|performance_glitch_user|secret_sauce|

Scenario: Navigate to the website homepage
Given I am on main application page
When I wait until element located by `caseSensitiveText(Swag Labs)` appears
Then `${current-page-url}` is equal to `https://www.saucedemo.com/`
When I take screenshot

Scenario: Log In
When I enter  `<userName>` in field located by `xpath(//*[@id="user-name"])`
When I enter  `<password>` in field located by `xpath(//*[@id="password"])`
When I click on element located by `xpath(//*[@id="login-button"])`
Then `${current-page-url}` is equal to `https://www.saucedemo.com/inventory.html`

Scenario: Add item to the shopping cart
When I click on element located by `<itemName>`
When I click on element located by `${addToCart}`
When I click on element located by `${back}`
When I click on element located by `<itemPageId>`
When I click on element located by `${addToCart}`
When I click on element located by `${back}`
When I click on element located by `<addToCardButtonId>`
Examples:
|itemName                      |itemPageId                         |addToCardButtonId                                    |
|linkText(Sauce Labs Backpack) |xpath(//*[@id="item_0_title_link"])|xpath(//*[@id="add-to-cart-sauce-labs-bolt-t-shirt"])|


Scenario: Validate the num of items in the shopping cart

Then number of elements found by `xpath(//span[contains(@class,'badge') and contains(text(),3)])` is equal to `1`


Scenario: Log Out
When I click on element located by `cssSelector(#react-burger-menu-btn)`
When I click on element located by `xpath(//*[@id="reset_sidebar_link"])`
When I click on element located by `xpath(//*[@id="logout_sidebar_link"])`

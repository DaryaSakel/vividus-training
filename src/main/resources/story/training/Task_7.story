Meta:
    @group Training
    @requirementId MyTask-0007

Lifecycle:
Examples:
|userName               |password    |
|standard_user          |secret_sauce|

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

Scenario: Populate checkout data
When I click on element located by `xpath(//*[@id="shopping_cart_container"])`
When I click on element located by `buttonName(Checkout)`
When I enter  `#{generate(Name.firstName)}` in field located by `xpath(//*[@id="first-name"])`
When I enter  `#{generate(regexify '[A-Z]{3}[a-z]{4}')}` in field located by `xpath(//*[@id="last-name"])`
When I enter  `#{generate(regexify '[A-Z]{3}-[1-9]{5}')}` in field located by `xpath(//*[@id="postal-code"])`
When I take screenshot

Scenario: Complete checkout process
When I click on element located by `buttonName(Continue)`
When I click on element located by `buttonName(Finish)`
Then `${current-page-url}` is equal to `https://www.saucedemo.com/checkout-complete.html`
When I save text of element located by `xpath(//h2)` to scenario variable `thankYou`
Given I initialize scenario variable `message` with value `#{loadResource(/data/message.txt)}`
Then `#{eval(`${thankYou}` == `${message}`)}` is = `true`

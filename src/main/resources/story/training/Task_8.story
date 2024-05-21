Meta:
    @group Training
    @requirementId MyTask-0008

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

Scenario: Add items to the shopping cart
When I click on element located by `xpath(//*[@class="product_sort_container"])`
When I click on element located by `<sortingValue>`
When I click on element located by `xpath(//*[@class="inventory_list"]/div[1]/div[@class="inventory_item_img"])`
When I click on element located by `${addToCart}`
When I wait until element located by `<cartBadgeCount>` appears
When I click on element located by `${back}`

Examples:
|sortingValue                        |cartBadgeCount                                          |
|xpath(//*[contains(@value,'lohi')]) |xpath(//*[@class="shopping_cart_link"]/span[text()='1'])|
|xpath(//*[contains(@value,'hilo')]) |xpath(//*[@class="shopping_cart_link"]/span[text()='2'])|

Scenario: Populate checkout data
When I click on element located by `xpath(//*[@id="shopping_cart_container"])`
When I click on element located by `buttonName(Checkout)`
When I enter  `#{generate(Name.firstName)}` in field located by `xpath(//*[@id="first-name"])`
When I enter  `#{generate(regexify '[A-Z]{3}[a-z]{4}')}` in field located by `xpath(//*[@id="last-name"])`
When I enter  `#{generate(regexify '[A-Z]{3}-[1-9]{5}')}` in field located by `xpath(//*[@id="postal-code"])`
When I click on element located by `buttonName(Continue)`

Scenario: Validate order summary and complete order
Then `${current-page-url}` is equal to `https://www.saucedemo.com/checkout-step-two.html`
When I save text of element located by `xpath(//h2)` to scenario variable `subTotal1`
When I save text of element located by `xpath(//h2)` to scenario variable `subTotal2`

//*[@id="checkout_summary_container"]/div/div[1]/div[3]/div[2]/div[2]/div
driver.findElement(By.xpath("//div[@class="inventory_item_price"][normalize-space()="$7.99"]"))

//*[@id="checkout_summary_container"]/div/div[1]
/div[3]/div[2]/div[2]/div


//div[@class="cart_list"]/div[1]/div

div[contains(@class,"inventory_item_price")]

driver.findElement(By.xpath("//body/div[@id="root"]/div[@id="page_wrapper"]/div[@id="contents_wrapper"]/div[@id="checkout_summary_container"]/div/div[@class="cart_list"]/div[3]/div[2]"))
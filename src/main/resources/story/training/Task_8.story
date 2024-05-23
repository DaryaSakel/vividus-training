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
When I ${baselineAction} baseline with name `checkout`


Scenario: Validate order summary and complete order
Then `${current-page-url}` is equal to `https://www.saucedemo.com/checkout-step-two.html`
When I save text of element located by `xpath(//*[@class="cart_list"]/div[3]/div[2]/div[2]/div[1])` to scenario variable `subTotal1`
Given I initialize SCENARIO variable `sub1` with value `#{replaceFirstByRegExp(\$(\d*\.\d{2}), $1, ${subTotal1})}`
When I save text of element located by `xpath(//*[@class="cart_list"]/div[4]/div[2]/div[2]/div[1])` to scenario variable `subTotal2`
Given I initialize SCENARIO variable `sub2` with value `#{replaceFirstByRegExp(\$(\d*\.\d{2}), $1, ${subTotal2})}`
When I save text of element located by `xpath(//*[@class="summary_subtotal_label"])` to scenario variable `subTotal`
Given I initialize SCENARIO variable `sub` with value `#{replaceFirstByRegExp(Item total: \$(\d*\.\d*), $1, ${subTotal})}`
Then `#{eval(${sub1} + ${sub2})}` is = `${sub}`
When I save text of element located by `xpath(//*[@class="summary_tax_label"])` to scenario variable `tax1`
Given I initialize SCENARIO variable `tax` with value `#{replaceFirstByRegExp(Tax: \$(\d*\.\d*), $1, ${tax1})}`
When I save text of element located by `xpath(//*[@class="summary_total_label"])` to scenario variable `total1`
Given I initialize SCENARIO variable `total` with value `#{replaceFirstByRegExp(Total: \$(\d*\.\d*), $1, ${total1})}`
Then `#{round(#{eval(${sub} + ${tax})}, 2)}` is = `${total}`
When I ${baselineAction} baseline with name `complete`
When I click on element located by `buttonName(Finish)`
When I save text of element located by `xpath(//h2)` to scenario variable `thankYou`
Given I initialize scenario variable `message` with value `#{loadResource(/data/message.txt)}`
Then `#{eval(`${thankYou}` == `${message}`)}` is = `true`



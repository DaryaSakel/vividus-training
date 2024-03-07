GivenStories: story/demo/Homepage_Demo.story

Scenario: Log in as a Good User
When I enter `${swagGoodUserName}` in field located by `xpath(//*[@id="user-name"])`
When I enter `${swagPassword}` in field located by `xpath(//*[@id="password"])`
When I click on element located by `xpath(//*[@id="login-button"])`
When I wait until element located by `xpath(//*[@id="header_container"]/div[1]/div[2]/div)` appears
Then `${current-page-url}` is equal to `https://www.saucedemo.com/inventory.html`
Then number of elements found by `className(inventory_item)` is equal to `6`
When I take screenshot

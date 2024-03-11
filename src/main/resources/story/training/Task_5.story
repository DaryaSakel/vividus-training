Scenario: Navigate to the website homepage
Given I am on main application page
When I take screenshot of Homepage

Scenario: Log in as Locked User
When I login with ${userName} and ${password}
Then `${current-page-url}` is equal to `https://www.saucedemo.com/inventory.html`
Then number of elements found by `className(inventory_item)` is equal to `6`
When I take screenshot

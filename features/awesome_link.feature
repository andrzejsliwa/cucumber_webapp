Feature: My Awesome Link
  Scenario: Clicking the awesome link shows awesome text
    Given I am on the home page
    Then  I should see "My Webapp"
    And   I follow "Click on this link to make cool stuff happen"
    And   I should see "This is totally awesome"
		And   show me the page

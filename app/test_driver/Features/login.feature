

Feature: Create Account
  Scenario: when email and password are specified and create is clicked
    Given I have "email" and "password" and "Create"
    When I fill the "email" field with "nabdbab@gmail.com"
    And I fill the "password" filed with "hadnhbdba"
    Then I tap the "Create" button
    Then "User" should be diferent than "null"

Feature: Login into an existing Account
  Scenario: when email and password are specified and login is clicked
    Given I have "email" and "password" and "Sign In"
    When I fill the "email" field with "nabdbab@gmail.com"
    And I fill the "password" filed with "hadnhbdba"
    Then I tap the "Sign In" button
    Then "User" should be diferent than "null"

Feature: Login into a non-existing Account
  Scenario: when email and password are specified and login is clicked
    Given I have "email" and "password" and "Sign In"
    When I fill the "email" field with "nsawfcb@gmail.com"
    And I fill the "password" filed with "hadnhbdba"
    Then I tap the "Sign In" button
    Then "User" should be "null"
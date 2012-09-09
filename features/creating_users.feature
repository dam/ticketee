Feature: creating users
  In order to add new users in the system
  As an admin
  I want to be abble to add them under the admin namespace
  
  Background:
    Given there are the following users:
    | email              | password | admin |
    | admin@ticketee.com | password | true  |
    And I am signed in as them
    Given I am on the homepage
    When I follow "Admin"
    And I follow "Users"
    And I follow "New User"
  
  Scenario: Creating a new User
    And I fill "Email" in with "new@ticketee.com"
    And I fill "Password" in with "password"
    And I press "Create User" button
    Then I should see "User has been created."
  
  Scenario: Leaving email blank resulting in an error
    And I fill "Email" in with ""
    And I fill "Password" in with "password"
    And I press "Create User" button
    Then I should see "User has not been created."
    And I should see "Email can't be blank"
    
  Scenario: Creating an admin user
    When I fill "Email" in with "newadmin@ticketee.com"
    And I fill "Password" in with "password"
    And I check "Is an admin?"
    And I press "Create User" button
    Then I should see "User has been created"
    And I should see "newadmin@ticketee.com (Admin)"

    
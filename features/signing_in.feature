Feature: Signing in
  In order to use the site
  As a User
  I want to signing in
  
  Scenario: signing in via confirmation
    Given there are the following users:
    | email             | password | unconfirmed |
    | user@ticketee.com | password | true        |
    And "user@ticketee.com" opens the email with subject "Confirmation instructions"
    And they click the first link in the email
    Then I should see "Your account was successfully confirmed"
    And I should see "Signed in as user@ticketee.com"
    
  Scenario: signing in via form
    Given there are the following users:
    | email             | password | 
    | user@ticketee.com | password | 
    And I am on the homepage
    When I follow "Sign in"
    And I fill "Email" in with "user@ticketee.com"
    And I fill "Password" in with "password"
    And I press "Sign in" button
    Then I should see "Signed in successfully."
Feature: Signing up
  In order to be attributed to my work
  As a User
  I want to be able to sign up
  
  Scenario: Signing up
    Given I am on the homepage
    When I follow "Sign up"
    And I fill "Email" in with "user@ticketee.com"
    And I fill "Password" in with "password"
    And I fill "Password confirmation" in with "password"
    And I press "Sign up" button
    Then I should see "You have signed up successfully."
    Then I should see "Please confirm your account before signing in."

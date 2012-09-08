Feature: Creating tickets

  Background:
    Given there is a project named "Internet Explorer"
    And there are the following users:
    | email             | password | 
    | user@ticketee.com | password | 
    And I am on the homepage
    When I follow "Internet Explorer"
    Then I should see "New ticket"
    And I follow "New ticket"
    Then I should see "You need to sign in or sign up before continuing."
    When I fill "Email" in with "user@ticketee.com"
    And I fill "Password" in with "password"
    And I press "Sign in" button
  
  Scenario: Creating a valid ticket
    When I fill "Title" in with "fake title"
    And I fill "Description" in with "fake description"
    And I press "Create Ticket" button
    Then I should see "Ticket has been created"
    Then I should see "Created by user@ticketee.com"
  
  Scenario: Creating a ticket without valid attributes fail
    And I press "Create Ticket" button
    Then I should see "Ticket has not been created"
    And I should see "Title can't be blank"
    And I should see "Description can't be blank"
    
  Scenario: description at least 10 characters
    When I fill "Title" in with "Non-standards compliance"
    And I fill "Description" in with "it sucks"
    And I press "Create Ticket" button
    Then I should see "Ticket has not been created."
    And I should see "Description is too short"


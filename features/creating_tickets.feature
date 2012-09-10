Feature: Creating tickets

  Background:
    Given there is a project named "Internet Explorer"
    And there are the following users:
    | email             | password | 
    | user@ticketee.com | password |
    And "user@ticketee.com" can view the "Internet Explorer" project
    And "user@ticketee.com" can "create tickets" in the "Internet Explorer" project
    And I am signed in as them
    And I am on the homepage
    When I follow "Internet Explorer"
    Then I should see "New Ticket"
    And I follow "New Ticket"

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

  Scenario: create a ticket with an attachment
    When I fill "Title" in with "Add documentation"
    And I fill "Description" in with "description to add attachment"
    And I attach the file "spec/fixtures/speed.txt" to "File"
    And I press "Create Ticket" button
    Then I should see "Ticket has been created."
    Then I should see "speed.txt" within "#ticket .asset"
    
  Scenario: creating a ticket with tags
    When I fill "Title" in with "testing tags"
    And I fill "Description" in with "new feature to add tags on tickets"
    And I fill "Tags" in with "ruby javascript"
    And I press "Create Ticket" button
    Then I should see "Ticket has been created."
    Then I should see "ruby" within "#ticket #tags"
    Then I should see "javascript" within "#ticket #tags"
    
    
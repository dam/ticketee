Feature:
  As a User
  I want have the possibility to delete directly a ticket
  
  Background:
    Given there are the following users:
    | email             | password |
    | user@ticketee.com | password |
    And I am signed in as them
    And there is a project named "project 1"
    And "user@ticketee.com" can view the "project 1" project
    And "user@ticketee.com" has created a ticket for this project:
    | title   | description               |
    | title 1 | description for project 1 |
    Given I am on the homepage
    When I follow "project 1"
    And I follow "title 1"
    
  Scenario: deleting a ticket
    When I follow "Delete Ticket"
    Then I should see "Ticket has been deleted."
    And I should be on the project page of "project 1"
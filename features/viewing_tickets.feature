Feature: Viewing tickets
  
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
    And there is a project named "Internet explorer"
    And "user@ticketee.com" can view the "Internet explorer" project
    And "user@ticketee.com" has created a ticket for this project:
    | title   | description                |
    | title 2 | description for project ie |
    And I am on the homepage

  Scenario: Viewing tickets for a given project
    When I follow "project 1"
    Then I should see "title 1"
    And I should not see "title 2"
    When I follow "title 1"
    Then I should see "title 1" within "#ticket h2"
    And I should see "description for project 1"
    
    When I follow "Ticketee"
    And I follow "Internet explorer"
    Then I should see "title 2"
    And I should not see "title 1"
    When I follow "title 2"
    Then I should see "title 2" within "#ticket h2"
    And I should see "description for project ie"
  
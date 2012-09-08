Feature: Viewing tickets
  
  Background:
    Given there is a project named "project 1"
    And that project has a ticket:
    | title   | description               |
    | title 1 | description for project 1 |
    And there is a project named "Internet explorer"
    And that project has a ticket:
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
  
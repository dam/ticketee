Feature: deleting projects
  As an user, I want be allowed to delete an object
  
  Scenario: delete a project
    Given there are the following users:
    | email              | password | admin |
    | admin@ticketee.com | password | true  |
    And I am signed in as them
    Given there is a project named "Project 1"
    And I am on the homepage
    When I follow "Project 1"
    And I follow "Delete Project"
    Then I should see "Project has been deleted"
    Then I should not see "Project 1"
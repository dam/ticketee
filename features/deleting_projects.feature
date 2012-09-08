Feature: deleting projects
  As an user, I want be allowed to delete an object
  
  Scenario: delete a project
    Given there is a project named "Project 1"
    And I am on the homepage
    When I follow "Project 1"
    And I follow "Delete project"
    Then I should see "Project has been deleted"
    Then I should not see "Project 1"
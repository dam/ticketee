Feature: creating projects
  In order to have projects to assigns to
  As a user
  I want to create them easily
  
  Scenario: Creating a project
    Given I am on the homepage
    When I follow "New Project"
    And I fill "name" in with "Test String 1"
    And I press "Create Project" button
    Then I should see "Project has been created"

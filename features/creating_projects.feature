Feature: creating projects
  In order to have projects to assigns to
  As a user
  I want to create them easily
  
  Background:
    Given I am on the homepage
    When I follow "New Project"
  
  Scenario: Creating a project
    And I fill "name" in with "Test String 1"
    And I press "Create Project" button
    Then I should see "Project has been created"
    And I should see "Test String 1"
    And I should see "Test String 1 - Projects - Ticketee"
    
  Scenario: Creating a project without a name
    And I press "Create Project" button
    Then I should see "Project has not been created"
    And I should see "Name can't be blank"
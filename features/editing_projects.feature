Feature: Editing a project
  As a user, I want be able to edit a project
  
  Background:
    Given there are the following users:
    | email              | password | admin |
    | admin@ticketee.com | password | true  |
    And I am signed in as them
    Given there is a project named "project 1"
    And I am on the homepage
    When I follow "project 1"
    And I follow "Edit Project"
  
  Scenario: Editing a project
    And I fill "name" in with "project 2"
    And I press "Update" button
    Then I should see "Project has been updated"
    Then I should be on the project page of "project 2"
    
  Scenario: Test validation during editing a project
    And I fill "name" in with " "
    And I press "Update" button
    Then I should see "Project has not been updated"
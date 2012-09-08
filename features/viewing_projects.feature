Feature: Viewing projects
  As a user, I want be able to see a list of projects
  
  Scenario: Listing all projects
    Given there is a project named "Project 1"
    And I am on the homepage
    When I follow "Project 1"
    Then I should be on the project page of "Project 1"

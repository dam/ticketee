Feature: Viewing projects
  As a user
  With given permissions
  I want be able to see a list of projects
  
  Background:
    Given there are the following users:
    | email             | password |
    | user@ticketee.com | password |
    And I am signed in as them
    And there is a project named "Project 1"
    And there is a project named "Internet Explorer"
    And "user@ticketee.com" can view the "Project 1" project
  
  Scenario: Listing all projects
    And I am on the homepage
    Then I should not see "Internet Explorer"
    When I follow "Project 1"
    Then I should be on the project page of "Project 1"

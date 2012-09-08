Feature:
  In order to alter ticket information
  As a user
  I want a form to edit the tickets

  Background:
    Given there is a project named "project 1"
    And that project has a ticket:
    | title   | description               |
    | title 1 | description for project 1 |
    Given I am on the homepage
    When I follow "project 1"
    And I follow "title 1"
    When I follow "Edit Ticket"
  
  Scenario: updating a ticket
    When I fill "Title" in with "Make it really shiny!"
    And I press "Update Ticket" button
    Then I should see "Ticket has been updated."
    And I should see "Make it really shiny!" within "#ticket h2"
    But I should not see "Make it shiny!"

  Scenario: updating a ticket with invalid information
    When I fill "Title" in with ""
    And I press "Update Ticket" button
    Then I should see "Ticket has not been updated."

  
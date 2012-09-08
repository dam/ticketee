Given /^there are the following users:$/ do |table|
  # table is a Cucumber::Ast::Table
 table.hashes.each do |attributes|
    unconfirmed = attributes.delete("unconfirmed") == "true"
    @user = User.create!(attributes)
    @user.confirm! unless unconfirmed
  end
end

Given /^I am signed in as them$/ do
  steps(%Q{
    Given I am on the homepage
    When I follow "Sign in"
    And I fill "Email" in with "#{@user.email}"
    And I fill "Password" in with "password"
    And I press "Sign in" button
    Then I should see "Signed in successfully."
  })
end

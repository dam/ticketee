Given /^I am on the homepage$/ do
  visit '/'
end

When /^I follow "([^"]*)"$/ do |link|
  click_link link
end

When /^I fill "([^"]*)" in with "([^"]*)"$/ do |field, text|
  fill_in(field, :with => text)
end

When /^I press "([^"]*)" button$/ do |button|
  click_button button
end

Then /^I should see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

Given /^there is a project named "([^"]*)"$/ do |name|
  @project = FactoryGirl.create(:project, :name => name)
end

Then /^I should be on the project page of "([^"]*)"$/ do |project_name|
  current_path.should include '/projects/' #ensure show action
  page.should have_content(project_name)
end

Then /^I should not see "([^"]*)"$/ do |text|
  if page.respond_to? :should_not
    page.should_not have_content(text)
  else
    assert ! page.has_content?(text)
  end
end

Given /^that project has a ticket:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |attributes|
    @project.tickets.create! attributes
  end
end

Then /^I should see "([^"]*)" within "([^"]*)"$/ do |text, selector|
  within(selector) do
    if page.respond_to? :should
      page.should have_content(text)
    else
      assert page.has_content?(text)
    end
  end
end

Given /^"([^"]*)" has created a ticket for this project:$/ do |email, table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |attributes|
    attributes.merge!(:user => User.find_by_email(email))
    @project.tickets.create! attributes
  end
end


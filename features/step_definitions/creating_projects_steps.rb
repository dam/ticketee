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


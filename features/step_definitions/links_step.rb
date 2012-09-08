Then /^I should not see the "([^"]*)" link$/ do |text|
  page.should_not have_css("a", :text => text)
end

Then /^I should see the "([^"]*)" link$/ do |text|
  page.should have_css("a", :text => text), ""
end


When /^I attach the file "([^"]*)" to "([^"]*)"$/ do |name, selector|
  attach_file(selector, name)
end

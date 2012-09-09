Given /^"([^"]*)" can view the "([^"]*)" project$/ do |email, project|
  Permission.create!(:user => User.find_by_email(email),
                     :thing => Project.find_by_name!(project),
                     :action => 'view')
end

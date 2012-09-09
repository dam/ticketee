Given /^"([^"]*)" can view the "([^"]*)" project$/ do |email, project|
  create_permission(email, Project.find_by_name!(project), 'view')
end

Given /^"([^"]*)" can "([^"]*)" in the "([^"]*)" project$/ do |email, permission, project|
  create_permission(email, Project.find_by_name!(project), permission)
end

def create_permission(email, object, allowed_action)
  Permission.create!(:user => User.find_by_email(email),
                     :thing => object,
                     :action => allowed_action)
end

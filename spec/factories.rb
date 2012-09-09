FactoryGirl.define do 
  factory :project, :class => Project do
    sequence(:name) { |n| "fake_name #{n}" }
  end
  
  factory :ticket, :class => Ticket do
    sequence(:description) { |n| "fake description #{n}" }
    sequence(:title) { |n| "fake title #{n}" }
    project_id '1'
    user_id '1'
  end
  
  factory :user, :class => User do
    sequence(:email) { |n| "user#{n}@ticketee.com" }
    password "password"
    password_confirmation "password"
    authentication_token '1234'
  end
  
  factory :admin, :parent => :user do
    admin true
  end
  
  factory :permission, :class => Permission do
    user_id '1'
    thing_id '1'
    thing_type 'type'
    action 'view'
  end
end

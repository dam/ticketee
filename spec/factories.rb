FactoryGirl.define do 
  factory :project, :class => Project do
    name "fake_name"
  end
  
  factory :ticket, :class => Ticket do
    description 'fake description'
    title 'fake title'
    project_id 1
  end
  
  factory :user, :class => User do
    sequence(:email) { |n| "user#{n}@ticketee.com" }
    password "password"
    password_confirmation "password"
  end
  
  factory :admin, :parent => :user do
    admin true
  end
end

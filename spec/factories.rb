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
    confirmation_token 'confirm token'
    confirmed_at 'a datetime'
    confirmation_sent_at 'a datetime'
  end
end

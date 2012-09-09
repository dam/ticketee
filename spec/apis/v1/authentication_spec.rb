require 'spec_helper'

describe "API authentication", :type => :api do
  it "returns an error message when user is not authenticate" do
    expected_message = {:error => "Token is invalid." }.to_json
    
    FactoryGirl.create(:user)
    get '/api/v1/projects.json', :token => ''
    last_response.body.should eql(expected_message)
  end
end

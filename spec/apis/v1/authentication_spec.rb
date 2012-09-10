require 'spec_helper'

describe "API authentication", :type => :api do
  it "returns an error message when user is not authenticate" do
    expected_message = {:error => "Token is invalid." }.to_json
    
    FactoryGirl.create(:user)
    get '/api/v1/projects.json', :token => ''
    last_response.body.should eql(expected_message)
  end
  
  context 'standard users' do
    let(:user) { create_user! }
    let(:token) { user.authentication_token }
    
    it "cannot create projects" do
      expected_error = {:error => "You must be an admin to do that." }
      
      post '/api/v1/projects.json', :token => token,
                                    :project => { :name => 'new project' }
    
      last_response.status.should == 401
      last_response.body.should eq(expected_error.to_json)
      Project.find_by_name('new project').should be_nil
    end
    
    it "cannot view projects without the given permission" do
      project = FactoryGirl.create(:project)
      expected_error = {:error => "The project you are looking for cannot be found." }
      
      get "/api/v1/projects/#{project.id}.json", :token => token
    
      last_response.status.should == 404
      last_response.body.should eq(expected_error.to_json)
    end
  end
end

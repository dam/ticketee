require 'spec_helper'

describe '/api/v1/projects', :type => :api do
  let (:user) { create_user! }
  let (:token) { user.authentication_token }
  
  #generate user permissions to use on these tests
  before do
    @project = FactoryGirl.create(:project)
    user.permissions.create!(:action => 'view', :thing => @project)
    @project2 = FactoryGirl.create(:project)
    user.permissions.create!(:action => 'view', :thing => @project2)
  end
 
  context "projects viewable by this user" do
    before do
      #create a project without authorization
      @project3 = FactoryGirl.create(:project, :name => 'Access Denied')
    end
    
    let (:url) { '/api/v1/projects' }
    
    it 'returns an array of json data on #index' do
      expected_result = [@project, @project2].to_json
      
      get "#{url}.json", :token => token
       
      last_response.status.should == 200
      last_response.body.should eq(expected_result)
      
      #testing the parsed data
      resulting_projects = JSON.parse(last_response.body)
      resulting_projects.any? do |project|
        project['name'] == 'fake_name 1'
      end.should be_true
      
      #testing access restricition
      resulting_projects.any? do |p|
        p["name"] == "Access Denied"
      end.should be_false
    end
  end
end

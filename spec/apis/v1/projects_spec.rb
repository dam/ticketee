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
    
    it 'serve XML data on #index' do
      expected_result = [@project, @project2].to_xml
      
      get "#{url}.xml", :token => token
      last_response.body.should eq(expected_result)
    end 
  end

  context 'creating a project' do
    let(:url) { '/api/v1/projects' }
    
    #user must be an admin
    before do
      user.admin = true
      user.save
    end
    
    it "create successfull data from JSON request to #create" do
      post "#{url}.json", :token => token, :project => { :name => 'project name' }
      
      expected_result = Project.find_by_name('project name')
      generated_route = "/api/v1/projects/#{expected_result.id}"
      
      last_response.status.should == 201
      last_response.headers['Location'].should == generated_route
      last_response.body.should eql(expected_result.to_json)
    end
    
    it "returns the request with errors on unvalid request to #create" do
      post "#{url}.json", :token => token, :project => { :name => '' }
      
      expected_result = {:errors => { 'name' => ["can't be blank"]} }
      last_response.status.should == 422
      last_response.body.should eql(expected_result.to_json)
    end
  end

  context 'show' do
    let (:url) { "/api/v1/projects/#{@project.id}" }
    
    before do
      FactoryGirl.create(:ticket, :project => @project)
    end
    
    it "should return a customed JSON response" do
      expected_result = @project.to_json(:methods => 'last_ticket' )
      
      get "#{url}.json", :token => token
      
      last_response.status.should == 200
      last_response.body.should eql(expected_result)
    end
  end

  context 'updating a project' do
    before do
      user.admin = true
      user.save
    end
    
    let(:url) { "/api/v1/projects/#{@project.id}" }
    
    it 'successfull update a project and return the json response' do
      put "#{url}.json", :token => token, :project => { :name => 'new name'}
      
      last_response.status.should == 204
      last_response.body.should eq("")
      @project.reload
      @project.name.should == 'new name'
    end
    
    it "return an error status when not valid data given to update" do
      expected_error = {:errors => { :name => ["can't be blank"] } }
      put "#{url}.json", :token => token, :project => { :name => ''}
      
      last_response.status.should == 422
      last_response.body.should eql(expected_error.to_json)
    end
  end

  context 'destroy a project' do
    before do
      user.admin = true
      user.save
    end
    
    let(:url) { "/api/v1/projects/#{@project.id}" }
    
    it 'successfull delete a project' do
      delete "#{url}.json", :token => token
      
      last_response.status.should == 204
    end 
  end
end

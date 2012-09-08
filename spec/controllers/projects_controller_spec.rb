require 'spec_helper'

describe ProjectsController do
  describe 'GET index' do
    it "assigns @projects" do
      project = FactoryGirl.create(:project)
      get :index
      response.should be_success
      assigns(:projects).should eq([project])
    end
    
    it "renders template index" do
      get :index
      response.should render_template('index')
    end
  end
  
  describe 'GET new' do
    it 'renders template new' do
      get :new
      response.should render_template('new')
    end
    
    it 'assigns variable @project' do
      get :new
      assigns(:project).should_not be_nil
    end
  end
  
  describe 'PUT create' do
    context "valid project resource" do
      it 'should assign @project and save the resource' do
        put :create, :project => { :name => 'fake name' }
        assigns(:project).should_not be_nil
        Project.all.size.should == 1
      end
      
      it 'should redirect to show action' do
        put :create, :project => { :name => 'fake name' }
        response.should redirect_to(project_path({:id => '1' }))
      end 
    end
    
    context "unvalid project resource" do
      it "should not save invalid project and render new template" do
        put :create, :project => { :name => '' }
        Project.all.should be_empty
        response.should render_template('new')
      end
    end
  end
   
  describe 'GET show' do
    it "should assign @project" do
      project = FactoryGirl.create(:project)
      get :show, :id => project.id
      response.should be_success
      assigns(:project).should eq(project)
    end
    
    it "should render template show" do
      project = FactoryGirl.create(:project)
      get :show, :id => project.id
      response.should render_template('show')
    end
  end
  
  describe 'GET edit' do
    it 'assigns variable @project' do
      project = FactoryGirl.create(:project)
      get :edit, :id => project.id
      assigns(:project).should eq(project)
    end
      
    it 'renders template edit' do
      project = FactoryGirl.create(:project)
      get :edit, :id => project.id
      response.should render_template('edit')
    end
  end
  
  describe 'PUT update' do
    context "valid project resource" do
      it 'should assign @project and update the resource' do
        project = FactoryGirl.create(:project)
        put :update, :id => project.id, :project => { :name => 'updated name' }
        assigns(:project).should eq(project)
        Project.find(1).name.should == 'updated name'
      end
      
      it 'should redirect to show action' do
        project = FactoryGirl.create(:project)
        put :update, :id => project.id, :project => { :name => 'updated name' }
        response.should redirect_to(project_path({:id => '1' }))
      end 
    end
    
    context "unvalid project resource" do
      it "should not save invalid project and render new template" do
        project = FactoryGirl.create(:project)
        put :update, :id => project.id, :project => { :name => '' }
        response.should render_template('edit')
      end
    end
  end
 
  describe 'DELETE destroy' do
    it "should delete given resource" do
      project = FactoryGirl.create(:project)
      delete :destroy, :id => project.id
      assigns(:project).should eq(project)
      Project.all.should be_empty
    end
    
    it 'should redirect to index action' do
      project = FactoryGirl.create(:project)
      delete :destroy, :id => project.id
      response.should redirect_to(projects_path)
    end
  end
  

  
  describe "#find_project before filter" do
    it "displays an error for a missing project" do
      get :show, :id => "not-here"
      response.should redirect_to(projects_path)
      message = "The project you were looking for could not be found."
      flash[:alert].should eql(message)
    end
  end
end

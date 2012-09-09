require 'spec_helper'
include Devise::TestHelpers

describe ProjectsController do
  
  let (:user) { create_user! }
  let (:admin) { create_admin! }
  let (:project) { FactoryGirl.create(:project) }
  let (:permission) do
    Permission.create!(:user => user,
                       :thing => project,
                       :action => 'view')
  end

  context "standard users" do
    
    describe 'admin restricted actions' do
      { "new" => "get",
        "create" => "post",
        "edit" => "get",
        "update" => "put",
        "destroy" => "delete"
      }.each do |action, method|
        it "cannot access the #{action} action" do
          sign_in(:user, user)
          send(method, action.dup, :id => project.id)
          response.should redirect_to(root_path)
          flash[:alert].should eql("You must be an admin to do that.")
        end
      end
    end
    
    describe 'actions where permissions are required' do
      
      context 'without permissions' do  
        it 'cannot access the show action' do
          sign_in(:user, user)
          get :show, :id => project.id
          response.should redirect_to(projects_path)
          flash[:alert].should eq("The project you were looking for could not be found.")
        end
      end
      
      context 'with permission' do
        before :each do
          permission
          sign_in(:user, user)
        end
        
        describe 'GET show' do   
          it "should assign @project" do
            get :show, :id => project.id
            response.should be_success
            assigns(:project).should eq(project)
          end
        
          it "should render template show" do
            get :show, :id => project.id
            response.should render_template('show')
          end
        end
        
        describe 'GET index' do
          it "assigns @projects" do
            get :index
            response.should be_success
            assigns(:projects).should eq([project])
          end
        
          it "renders template index" do
            get :index
            response.should render_template('index')
          end
        end
      end
    end
  end

  context 'admin users' do
    before :each do
      sign_in(:user, admin)
    end
    
    describe 'as admin, I have access to restricted actions' do
      describe "#find_project before filter" do
        it "displays an error for a missing project" do
          get :show, :id => "not-here"
          response.should redirect_to(projects_path)
          message = "The project you were looking for could not be found."
          flash[:alert].should eql(message)
        end
      end
      
      context 'where permissions are not required' do
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
      end
      
      context "where permissions are required" do
        before :each do
          Permission.create!(:user => admin,
                             :thing => project,
                             :action => 'view')
          sign_in(:user, admin)
        end
            
        describe 'GET edit' do
          it 'assigns variable @project' do
            get :edit, :id => project.id
            assigns(:project).should eq(project)
          end
            
          it 'renders template edit' do
            get :edit, :id => project.id
            response.should render_template('edit')
          end
        end
        
        describe 'PUT update' do
          context "valid project resource" do
            it 'should assign @project and update the resource' do
              put :update, :id => project.id, :project => { :name => 'updated name' }
              assigns(:project).should eq(project)
              Project.find(1).name.should == 'updated name'
            end
            
            it 'should redirect to show action' do
              put :update, :id => project.id, :project => { :name => 'updated name' }
              response.should redirect_to(project_path({:id => '1' }))
            end 
          end
          
          context "unvalid project resource" do
            it "should not save invalid project and render new template" do
              put :update, :id => project.id, :project => { :name => '' }
              response.should render_template('edit')
            end
          end
        end
        
        describe 'DELETE destroy' do
          it "should delete given resource" do
            delete :destroy, :id => project.id
            assigns(:project).should eq(project)
            Project.all.should be_empty
          end
          
          it 'should redirect to index action' do
            delete :destroy, :id => project.id
            response.should redirect_to(projects_path)
          end
        end
      
      end 
    end
  end
end



require 'spec_helper'

describe 'Routes for projects' do
  
  describe 'REST' do
    it "routes to #index" do
      { :get => '/projects' }.should route_to(
        :controller => 'projects',
        :action => 'index'
      )
    end
    
    it "routes to #new" do
      { :get => '/projects/new' }.should route_to(
        :controller => 'projects',
        :action => 'new'
      )
    end
  
    it "routes to #create" do
      { :post => '/projects' }.should route_to(
        :controller => 'projects',
        :action => 'create'
      )
    end
  
    it "routes to #show" do
      { :get => '/projects/1' }.should route_to(
        :controller => 'projects',
        :action => 'show',
        :id => '1'
      )
    end
    
    it "routes to #edit" do
      { :get => '/projects/1/edit' }.should route_to(
        :controller => 'projects',
        :action => 'edit',
        :id => '1'
      )
    end
  
    it "routes to #update" do
      { :put => '/projects/1' }.should route_to(
        :controller => 'projects',
        :action => 'update',
        :id => '1'
      )
     end
     
    it "routes to #destroy" do
      { :delete => '/projects/1' }.should route_to(
        :controller => 'projects',
        :action => 'destroy',
        :id => '1'
      )
    end
  end
end

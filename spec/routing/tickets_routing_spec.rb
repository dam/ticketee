require 'spec_helper'

describe 'Routes for tickets' do
  
  describe 'REST nested with projects resource' do
    it "routes to #index" do
      { :get => '/projects/1/tickets' }.should route_to(
        :controller => 'tickets',
        :action => 'index',
        :project_id => '1'
      )
    end
    
    it "routes to #new" do
      { :get => '/projects/1/tickets/new' }.should route_to(
        :controller => 'tickets',
        :action => 'new',
        :project_id => '1'
      )
    end
    
    it "routes to #create" do
      { :post => '/projects/1/tickets/' }.should route_to(
        :controller => 'tickets',
        :action => 'create',
        :project_id => '1'
      )
    end
  
    it "routes to #show" do
      { :get => '/projects/1/tickets/1' }.should route_to(
        :controller => 'tickets',
        :action => 'show',
        :project_id => '1',
        :id => '1'
      )
    end
    
    it "routes to #edit" do
      { :get => '/projects/1/tickets/1/edit' }.should route_to(
        :controller => 'tickets',
        :action => 'edit',
        :project_id => '1',
        :id => '1'
      )
    end
  
    it "routes to #update" do
      { :put => '/projects/1/tickets/1' }.should route_to(
        :controller => 'tickets',
        :action => 'update',
        :project_id => '1',
        :id => '1'
      )
     end
     
    it "routes to #destroy" do
      { :delete => '/projects/1/tickets/1' }.should route_to(
        :controller => 'tickets',
        :action => 'destroy',
        :project_id => '1',
        :id => '1'
      )
    end
  end
end

require 'spec_helper'
include Devise::TestHelpers

describe Admin::UsersController do
  
  let (:user) { create_user! }
   
  context 'standard users' do
    before :each do
      sign_in(:user, user)
    end
    
    it "are not allowed to access the index action" do
      get :index
      response.should redirect_to(root_path)
      flash[:alert].should == "You must be an admin to do that."
    end
  end
end

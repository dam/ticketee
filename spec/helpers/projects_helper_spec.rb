require 'spec_helper'
include ProjectsHelper

describe ProjectsHelper do
  
  describe '#title' do
    #NOTE: problem with helper configuration, don t have rails helpers env available
    it "should return a String with pattern arg 1 - ... arg n - Ticketee" do
      project_name, second_arg = %w(fake_name fake_string)
      expected_output = "#{project_name} - #{second_arg} - Ticketee"
      
      ProjectsHelper.should_receive(:content_for).and_return(expected_output)
      ProjectsHelper::title(project_name, second_arg).should == expected_output
    end 
  end
  
  describe '#admins_only' do
   
    it 'returns nothing if no current user' do
      ProjectsHelper.stub!(:current_user).and_return(nil)
      ProjectsHelper::admins_only do
        'texte to try'
      end.should be_nil
    end
    
    it 'returns nothing if current user not admin' do
      ProjectsHelper.stub!(:current_user).and_return(FactoryGirl.build(:user))
      ProjectsHelper::admins_only do
        'texte to try'
      end.should be_nil
    end
    
    it 'returns block given if current user is admin' do
      text = 'texte to try'
      ProjectsHelper.stub!(:current_user).and_return(FactoryGirl.create(:admin))
      ProjectsHelper::admins_only do
        text
      end.should eq(text)
    end
  end
end

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
end

require 'spec_helper'

describe Permission do
 context "General" do
    it { should belong_to :user }
    it { should belong_to :thing } 

    it "should have valid factories" do
      FactoryGirl.build(:permission).should be_valid
    end
  end
end

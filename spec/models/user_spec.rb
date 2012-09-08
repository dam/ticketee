require 'spec_helper'

describe User do
  context "General" do
    it { should have_many :tickets }
  
    it "should have valid factories" do
      pending
      FactoryGirl.build(:user).should be_valid
    end
  end
end

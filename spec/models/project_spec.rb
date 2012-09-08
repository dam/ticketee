require 'spec_helper'

describe Project, '(General)' do
  it { should validate_presence_of :name }
  it { should have_many :tickets }
  
  it "should have valid factories" do
    FactoryGirl.build(:project).should be_valid
  end
end


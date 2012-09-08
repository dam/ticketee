require 'spec_helper'

describe Ticket do
  context "General" do
    it { should belong_to :project }
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should ensure_length_of(:description).is_at_least(10) }
    it { should belong_to :user }
  
    it "should have valid factories" do
      FactoryGirl.build(:ticket).should be_valid
    end
  end
end

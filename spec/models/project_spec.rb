require 'spec_helper'

describe Project, '(General)' do
  let(:project) { project = FactoryGirl.create(:project) }
  
  it { should validate_presence_of :name }
  it { should have_many :tickets }
  it { should have_many :permissions }
  
  it "should have valid factories" do
    FactoryGirl.build(:project).should be_valid
  end
  
  it "should establish a delete_all dependence to tickets" do
    project.tickets << FactoryGirl.create(:ticket)
    project.tickets << FactoryGirl.create(:ticket)
    project.tickets.size.should == 2
    project.destroy
    Ticket.all.should be_empty
  end
end

describe Project do
  let(:project) { project = FactoryGirl.create(:project) }
  let(:user) { user = FactoryGirl.create(:user) }
  
  describe '#readable_by' do
    it "should return no record if the user has no permissions" do
      Project.readable_by(user).should be_empty
    end
    
    it "should return the project under permissions for a given user" do
      permission = Permission.create!(:user => user,
                                      :thing => project,
                                      :action => 'view')
      Project.readable_by(user).should eq([project])
    end
  end
end


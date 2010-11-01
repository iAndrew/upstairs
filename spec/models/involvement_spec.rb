require 'spec_helper'

describe Involvement do

  before(:each) do
    @group = Factory.create(:group)
    @user = Factory.create(:user)
    role_attr = { :name => "C++ Developer",
                  :tech => "C++",                 # both may be replaced with Name
                  :type => "Developer",           # both may be replaced with Name
                  :area => "Technical" }      
    @role = Role.create( role_attr )
    @attributes = {:user_id => @user.id,
                   :status => "Senior", 
                   :role_id => @role.id, 
                   :start_date => Date::strptime("20100101","%Y%m%d"),
                   :end_date => nil,
                   :edited_by => "Alex"}
  end
  
  it "should be created given correct attributes" do
      @group.involvements.create!(@attributes)
  end

  describe "group associations" do
    before(:each) do
      @involvement = @group.involvements.create(@attributes)
    end  
    
    it "should have a group attribute" do
      @involvement.should respond_to(:group)
    end
    
    it "should have a correctly associated group" do
      @involvement.group_id.should == @group.id
      @involvement.group.should == @group
    end
  end
  
  describe "user associations" do
    before(:each) do
      @involvement = @group.involvements.create(@attributes)
    end  
    
    it "should have a user attribute" do
      @involvement.should respond_to(:user)
    end
    
    it "should have a correctly associated user" do
      @involvement.user_id.should == @user.id
      @involvement.user.should == @user
    end
  end

end

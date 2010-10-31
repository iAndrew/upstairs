require 'spec_helper'

describe UserInterest do
  before(:each) do
    @user = Factory(:user)
    @attr = { :interest => "value for interest" }
  end

  it "should create a new instance given valid attributes" do
    @user.interests.create!(@attr)
  end

  describe "user associations" do

    before(:each) do
      @user_interests = @user.interests.create(@attr)
    end

    it "should have a user attribute" do
      @user_interests.should respond_to(:user)
    end

    it "should have the right associated user" do
      @user_interests.user_id.should == @user.id
      @user_interests.user.should == @user
    end
  end

end

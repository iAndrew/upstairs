require 'spec_helper'

describe UserContact do
  before(:each) do
    @user = Factory(:user)
    @attr = { :contact_type => "contact type",
              :contact_value => "contact value"}
  end

  it "should create a new instance given valid attributes" do
    @user.create_user_contact(@attr)
  end

  describe "user associations" do

    before(:each) do
      @user_contact = @user.create_user_contact(@attr)
    end

    it "should have a user attribute" do
      @user_contact.should respond_to(:user)
    end

    it "should have the right associated user" do
      @user_contact.user_id.should == @user.id
      @user_contact.user.should == @user
    end
  end
end

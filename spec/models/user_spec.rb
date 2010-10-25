require 'spec_helper'

describe User do
  before(:each) do
    @attr = {
      :nickname              => "johnyD",
      :email                 => "john.doe@nobody.com",
      :password              => "foobar",
      :password_confirmation => "foobar"
    }
  end

  it "should create a new valid instance" do
    User.create!(@attr)
  end
  
  it "should require email" do
    no_name_user = User.new(@attr.merge(:email => ""))
    no_name_user.should_not be_valid
  end

  describe "password validation" do
    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end
  end
end

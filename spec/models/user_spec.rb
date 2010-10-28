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
  
  it "should accept valid email addresses" do
    addresses = addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end
  
  it "should reject invalid email addresses" do
    addresses = addresses = %w[user@foo,com THE_USER_foo.bar.org first.last@foo.]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should_not be_valid
    end
  end
  
  it "should reject duplicate email address, case-sensitivity check included" do
    upcase_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcase_email))
    user_with_duplicate_email = User.new(@attr.merge(:email => upcase_email))
    user_with_duplicate_email.should_not be_valid
  end

  describe "password validation" do
    it "should require a password if there is no authorizations for user" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end
                                                    
    it "should allow empty password if user has at least one authorization" do
      user = User.new(@attr.merge(:password => "", :password_confirmation => ""))
      user.authorizations.build(:provider => 'some_service', :uid => '2412423')
      user.should be_valid
    end
    
    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

    it "should reject long password" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
    
    describe "password_required? method" do
      it "should be true if user doesn't have any authorization and password field is not blank" do
        user = User.new(@attr)
        user.password_required?.should be_true
      end
      
      it "should be true if user has at least one authorization and password field is not blank" do
        user = User.new(@attr)
        user.authorizations.build(:provider => 'some_service', :uid => '2412423')
        user.password_required?.should be_true
      end
      
      it "should be true if user doesn't have any authorization and password field is blank" do
        user = User.new(@attr.merge(:password => ""))
        user.password_required?.should be_true
      end
      
      it "should be false if user has at least one authorization and password field is blank" do
        user = User.new(@attr.merge(:password => ""))
        user.authorizations.build(:provider => 'some_service', :uid => '2412423')
        user.password_required?.should be_false
      end
    end
  end
  
  describe "password encryption" do
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should have an encrypted password attribute" do
      @user.should respond_to(:pass)
    end
    
     describe "has_password? method" do
        it "should be true if the paswords match" do
          @user.has_password?(@attr[:password]).should be_true
        end

        it "should be false if the passwords don't match" do
          @user.has_password?("invalid").should be_false
        end
      end
      
      describe "authenticate method" do
        it "should return nil on email/password mismatch" do
          wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
          wrong_password_user.should be_nil
        end

        it "should return nil for an email address with no user" do
          nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
          nonexistent_user.should be_nil
        end

        it "should return the user on email/password match" do
          matching_user = User.authenticate(@attr[:email], @attr[:password])
          matching_user.should == @user
        end

      end
  end
end

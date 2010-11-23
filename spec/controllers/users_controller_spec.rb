require 'spec_helper'

describe UsersController do
  render_views
  
  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
    
    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "Sign up")
    end
    
    it "should have an email field" do
      get :new
      response.should have_selector("input[name='user[email]'][type='email']")            
    end
    
    it "should have a password field" do
      get :new
      response.should have_selector("input[name='user[password]'][type='password']")
    end
  end
  
  describe "GET 'avatar_cropping" do
    before(:each) do
      @user = test_sign_in(Factory(:user))
    end
    
    it "should redirect to edit user, if there is no avatar" do
      get :avatar_cropping, :id => @user
      response.should redirect_to :controller => 'users', :action => 'edit', :id => @user
    end
    
    it "should be successfull if user have an avatar" 
  end
end

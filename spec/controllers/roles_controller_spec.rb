require 'spec_helper'

describe RolesController do
  render_views
  
  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
  end
  
  describe "GET 'index'" do
    it "should be successful" do
      get :index
      response.should be_success
    end
  end
  
  describe "POST 'create'" do
    
    before(:each) do
      @attr = {:name => "Test Role", 
               :tech => "Test", 
               :role_type => "Role", 
               :area => "Management"}
    end
    
    it "should be successful" do
      post :create, :role => @attr
      response.should redirect_to(roles_path)
    end
    it "should change a role count" do
      lambda do
        post :create, :role => @attr
      end.should change(Role, :count).by(1)
    end
  end      

  describe "DELETE 'destroy'" do
    
    before(:each) do
      @attr = {:name => "Test Role", 
               :tech => "Test", 
               :role_type => "Role", 
               :area => "Management"}
      @role = Role.create!(@attr)
    end
    
    it "should be successful" do
      delete :destroy, :id => @role
      response.should redirect_to(roles_path)
    end
    
    it "should change number of roles" do
      lambda do
        delete :destroy, :id => @role
      end.should change(Role, :count).by(-1)  
    end
  end   
end

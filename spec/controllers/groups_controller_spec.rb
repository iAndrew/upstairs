require 'spec_helper'

describe GroupsController do
  render_views 
  
  describe "GET 'new'" do
    
    describe "for non signed in user" do
      it "should redirect to sign in" do
        get :new
        response.should redirect_to(signin_path)
      end
    end
    
    describe "for non signed in user" do
      before(:each) do
        test_sign_in(Factory(:user))
      end

      it "should be successful" do
        get :new
        response.should be_success
      end
    end
  end

  describe "GET 'index'" do
    it "should be successful" do
      get :index
      response.should be_success
    end
  end
  
  describe "GET 'show'" do
    before(:each) do
      @group = Factory(:group)
    end
    
    it "should be successful" do
      get :show, :id => @group
      response.should be_success
    end
  end  
  
  describe "POST 'create'" do
    
    before(:each) do
      @attr  = {:name => "Sample Project",
                :group_type => "PROJECT",
                :citation => "Imagination is more important than knowledge.",
                :citation_author => "Albert Einstein",
                :aim_of_project => "Some simple aim.",  
                :client => "Open source project",
                :web_page => "http://sample_app.com"}
    end
    
    it "should create a group" do
      lambda do
        post :create, :group => @attr
      end.should change(Group, :count).by(1)
    end
  end

  describe "DELETE 'destroy'" do
    before(:each) do
      @group = Factory(:group)
    end 
    
    it "should delete group" do
      lambda do
        delete :destroy, :id => @group
      end.should change(Group, :count).by(-1)
    end
  end

end

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
    
    describe "for signed in user" do
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
        
    describe "for non signed in user" do
      it "should redirect to sign in" do
        get :show, :id => @group
        response.should redirect_to(signin_path)
      end
    end    
    
    describe "for signed in user" do
      before(:each) do
        test_sign_in(Factory(:user))
      end
    
      it "should be successful" do
        get :show, :id => @group
        response.should be_success
      end
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
    
    describe "for non signed in user" do

      it "should redirect to sign in" do
        post :create, :id => @group, :group => @attr
        response.should redirect_to(signin_path)
      end
      
      it "should not create a group" do
        lambda do
        post :create, :id => @group, :group => @attr
        end.should_not change(Group, :count)
      end      
    end        
    
    describe "for signed in user" do
      before(:each) do
        test_sign_in(Factory(:user))
      end
      
      it "should create a group" do
        lambda do
          post :create, :group => @attr
        end.should change(Group, :count).by(1)
      end
    end
  end
  
  describe "POST 'update'" do
    
    before(:each) do
      @attr  = {:name => "Sample Project",
                :group_type => "PROJECT",
                :citation => "Imagination is more important than knowledge.",
                :citation_author => "Albert Einstein",
                :aim_of_project => "Some simple aim.",  
                :client => "Open source project",
                :web_page => "http://sample_app.com"}
      @group = Group.create(@attr)
      @new_attr = @attr.merge(:citation => "some new citation")
    end
    
    describe "for non signed in user" do
      it "should redirect to sign in" do
        post :update, :id=> @group, :group => @attr
        response.should redirect_to(signin_path)
      end
      
      it "should not update a group" do
        lambda do
          post :update, :id=> @group, :group => @attr
        end.should_not change(Group, :count)
      end      
    end        
    
    describe "for signed in user" do
      before(:each) do
        test_sign_in(Factory(:user))
      end    
      
      describe "and group administrator" do    
      
        it "should not create a new group" do
          lambda do
            post :update, :id=> @group, :group => @attr
          end.should_not change(Group, :count)
        end
      
        it "should update parameter" 
        
      end
      
      describe "and non group administrator" do    
        it "should not update parameter"
        
        it "should show error message" 
      end  

      it "should redirect to show" do
        post :update, :id=> @group.id, :group => @attr
        response.should redirect_to(group_path(@group))
      end
    end
  end  

  describe "DELETE 'destroy'" do
    
    before(:each) do
      @group = Factory(:group)
    end 
    
    describe "for non signed in user" do
      it "should redirect to sign in" do
        delete :destroy, :id => @group
        response.should redirect_to(signin_path)
      end
    end
    
    describe "for signed in user" do
      before(:each) do
        test_sign_in(Factory(:user))
      end      
      
      describe "and group administrator" do
        
        it "should delete group" do
          lambda do
            delete :destroy, :id => @group
          end.should change(Group, :count).by(-1)
        end

        it "should redirect to index" do
            response.should redirect_to(groups_path)
        end        
      end
        
      describe "and non group administrator" do    
        it "should not delete group"
        
        it "should show error message" 

        it "should redirect to show" 
      end  
    end
  end

end

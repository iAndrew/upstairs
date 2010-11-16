require 'spec_helper'

describe InvolvementsController do
  render_views
  
  before(:each) do
    @group = Factory.create(:group)
    @user = Factory.create(:user)    
    role_attr = { :name => "C++ Developer",
                  :tech => "C++",                 # both may be replaced with Name
                  :type => "Developer",           # both may be replaced with Name
                  :area => "Technical" }      
    @role = Role.create( role_attr )
    @attr = {:user_id => @user.id,
             :status => "Senior", 
             :role_id => @role.id, 
             :start_date => Date::strptime("20100101","%Y%m%d"),
             :end_date => nil,
             :edited_by => "Alex"}
  end

  describe "GET 'new'" do
  
    describe "for non signed in user" do
      it "should redirect to sign in" do
        get :new, {:group_id => @group.id}
        response.should redirect_to(signin_path)
      end
    end
      
    describe "for signed in user" do
      before(:each) do
        test_sign_in(@user)
      end
            
      it "should check permissions"      
            
      it "should be successful" do
        puts "Group id #{@group.id}" 
        get :new, {:group_id => @group.id}
        response.should be_success
      end
    end
  end

  describe "POST 'create'" do
    describe "for non signed in user" do
      it "should redirect to sign in" do
        post :create, :group_id => @group.id, :involvement => @attr
        response.should redirect_to(signin_path)
      end
    end  
    
    describe "for signed in user" do
      before(:each) do
        test_sign_in(@user)
      end    
      
      it "should create a involvement given correct attributes" do
        lambda do
          post :create, :group_id => @group.id, :involvement => @attr
        end.should change(Involvement, :count).by(1)
      end
      
      it "should redirect to group path" do
        post :create, :group_id => @group.id, :involvement => @attr
        response.should redirect_to(group_path(@group))
      end
    end
  end

  describe "DELETE 'destroy'" do
  
    before(:each) do
      @involvement = @group.involvements.create!(@attr)
    end
  
    describe "for non signed in user" do
      it "should redirect to sign in" do
         delete :destroy, :id => @involvement
        response.should redirect_to(signin_path)
      end
    end  
  
    describe "for signed in user" do
      before(:each) do
        test_sign_in(@user)
      end
        
      it "should check permissions"      
      
      it "should reduce number of involvements" do
        lambda do
          delete :destroy, :id => @involvement
        end.should change(Involvement, :count).by(-1)
      end

      it "should redirect to group page" do
        delete :destroy, :id => @involvement
        response.should redirect_to(group_path(@group))
      end
      
    end
  end
end

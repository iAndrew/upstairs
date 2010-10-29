require 'spec_helper'

describe Involvement do

  # it "can be created from User using get_involved" do
  #   User.should respond_to(:get_involved)
  # end
  # 
  # it "can be created from Group using involve_in" do
  #   Group.should respond_to(:involve_in)
  # end
  # 
  # it "can be removed using remove_involvement" do
  #   Involvement.should respond_to(:remove_involvement)
  # end
  # 
  # it "can be terminated using finish_involvement" do
  #   Involvement.should respond_to(:finish_involvement)
  # end
  # 
  # it "can be editted using edit_involvement" do
  #   Involvement.should respond_to(:edit_involvement)
  # end

  describe "created" do
    before(:each) do
      @user = Factory.create(:user)
      @group = Factory.create(:group)
      role_attr = { :name => "C++ Developer",
                    :tech => "C++",                 # both may be replaced with Name
                    :type => "Developer",           # both may be replaced with Name
                    :area => "Technical" }      
      @role = Role.create( role_attr )
      @attributes = {:status => "value", 
                     :role_id => @role.id, 
                     :start_date => Date::strptime("20100101","%Y%m%d"),
                     :end_date => nil,
                     :edited_by => "Alex"}
    end

    # describe "from user" do
    #   
    #   it "should create a involvement given correct attributes" do
    #     @user.get_involved(@group, @attributes)
    #   end
    # 
    # end
    # 
    # describe "from user" do
    #   
    #   it "should create a involvement given correct attributes" do
    #     @user.get_involved(@group, @attributes)
    #   end
    # 
    # end
  end
end

require 'spec_helper'

describe Role do
  before (:each) do
    @attr = { :name       => "C++ Developer",
              :tech       => "C++",                 # both may be replaced with Name
              :role_type  => "Developer",      # both may be replaced with Name
              :area       => "Technical" }
  end
  
  it "should be created a valid attributes given" do
    Role.create!(@attr).should be_valid
  end
  
  describe "name" do
    it "should be required" do
      Role.new(@attr.merge(:name => "")).should_not be_valid
    end
    
    it "should be unique" do
      Role.create!(@attr).should be_valid
      Role.new(@attr).should_not be_valid
    end
  end

  describe "area" do
    it "should be required" do
      Role.new(@attr.merge(:area => "")).should_not be_valid
    end
  end  
end

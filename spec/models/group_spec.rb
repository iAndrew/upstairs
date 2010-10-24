require 'spec_helper'

describe Group do

  before(:each) do
    @attr  = {:name => "Sample Project",
              :type => "PROJECT",
              :citation => "Imagination is more important than knowledge.",
              :citation_author => "Albert Einstein",
              :aim_of_project => "Some simple aim.",  
              :client => "Open source project",
              :web_page => "http://sample_app.com"}
  end
  
  it "should create a new group with given attributes" do
    Group.create!(@attr)
  end
  
  describe "name" do
    it "should be mandatory" do
      @attr[:name] = ""
      Group.new(@attr).should_not be_valid
    end    
    
    it "should be unique" do
      Group.create!(@attr)
      Group.new(@attr).should_not be_valid
    end
    
    it "should be between 8 and 50 chars" do
      @attr[:name] = "a"*7
      Group.new(@attr).should_not be_valid
      @attr[:name] = "a"*51
      Group.new(@attr).should_not be_valid
    end
  end
  
  describe "type" do
    it "should be mandatory" do
      @attr[:type] = ""
      Group.new(@attr).should_not be_valid
    end  
    
     it "can be GROUP" do
      @attr[:type] = "GROUP"
      Group.new(@attr).should be_valid
    end   
    
    it "can be PROJECT" do
      @attr[:type] = "PROJECT"
      Group.new(@attr).should be_valid
    end           
    
    it "must be either PROJECT or GROUP" do
      @attr[:type] = "DIVISION"
      Group.new(@attr).should_not be_valid
    end     
  end
  
  describe "citation" do
    it "can be empty" do 
      @attr[:citation] = ""
      @attr[:citation_author] = "" 
      Group.new(@attr).should be_valid
    end
    
    it "shouldnt be empty if citation_author is not empty" do
      @attr[:citation] = ""
      Group.new(@attr).should_not be_valid
    end
  end
  
  describe "citation_author" do
    it "can be empty if citation is not" do 
      @attr[:citation_author] = ""
      Group.new(@attr).should be_valid
    end
  end
  
  describe "client" do
    it "can't be empty" do
      @attr[:client] = ""
      Group.new(@attr).should_not be_valid      
    end
    
    it "can be between 4 and 50 chars" do
      @attr[:client] = "a"*3
      Group.new(@attr).should_not be_valid     
      @attr[:client] = "a"*51
      Group.new(@attr).should_not be_valid          
    end
  end

  describe "web_page" do
    it "can be empty" do
      @attr[:web_page] = ""
      Group.new(@attr).should be_valid      
    end  
    
    it "should have a valid address" do
      @attr[:web_page] = "vaaaa"
      Group.new(@attr).should_not be_valid      
    end    
        
    it "must be less then 50 chars" do
      @attr[:web_page] = "http://a.com/"+"a"*38
      Group.new(@attr).should_not be_valid          
    end    
  end
end

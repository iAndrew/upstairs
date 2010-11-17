require 'spec_helper'

describe PagesController do

  describe "GET 'home'" do
    describe 'for signed in user' do
      before(:each) do
        test_sign_in(Factory(:user))
      end
    
      it "should be successful" do
        get 'home'
        response.should be_success
      end
    end
  end
end

require 'spec_helper'

describe SessionsController do

  before(:each) do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = {
      'uid' => '12345',
      'provider' => 'facebook',
      'info' => {
        'name' => 'Bob'
      }
    }
  end

  describe "GET 'new'" do
    it "redirectes users to authentication" do
      get 'new'
      response.should render_template 'signin'
    end
  end

  describe "creates new user" do
    it "redirects new users with blank email to fill in their email" do
      @user = create(:user)
      visit '/auth/facebook'
      current_path.should == edit_user_path(@user)
    end
    it "redirects users with email back to root_url" do
      pending
      @user = create(:user, :email => "Tester@testing.com")
      visit '/auth/facebook'
      current_path.should == '/'
    end
  end

end

require 'spec_helper'

describe SessionsController do

  before(:each) do
    OmniAuth.config.test_mode = true
    omniauth_hash = FactoryGirl.attributes_for(:people)
    OmniAuth.config.add_mock(:facebook, omniauth_hash)
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end

  after do
    OmniAuth.config.test_mode = false
  end

  describe "GET 'new'" do
    it "redirectes users to authentication" do
      get 'new'
      response.should render_template 'signin'
    end
  end

  describe "creates new user" do
    it "redirects new users with blank email to fill in their email" do
      @user = FactoryGirl.create(:user)
      visit '/auth/facebook'
      current_path.should == edit_user_path(@user)
    end
    it "redirects users with email back to root_url" do
      @user = FactoryGirl.create(:user, :email => "Tester@testing.com")
      visit '/auth/facebook'
      current_path.should == "/users/#{@user.id}"
    end
  end

end

require 'spec_helper'

describe ServiceController do

  before do
    @user = create(:user)
  end

  describe "GET 'google_places'" do
    context "when logged in" do
      before do
        session[:user_id] = @user.id
      end
      it "returns http success only when logged in" do
        get 'google_places', :latitude => "100", :longitude => "100"
        response.should be_success
        response.header['Content-Type'].should include 'application/json'
      end
      it "returns http fail without paramater" do
        get 'google_places'
        response.should_not be_success
      end
    end
    context "when not logged in" do
      before do
        session[:user_id] = nil
      end
      it "returns error" do
        get 'google_places', :latitude => "100", :longitude => "100"
        response.should_not be_success
      end
    end
  end
end

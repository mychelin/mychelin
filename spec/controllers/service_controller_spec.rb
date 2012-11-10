# -*- coding: utf-8 -*-
require 'spec_helper'

describe ServiceController do

  before do
    @user = create(:user)
  end

  describe "GET 'list_restaurants'" do
    context "when logged in" do
      before do
        session[:user_id] = @user.id
      end
      it "returns http success only when logged in" do
        get 'list_restaurants', :latitude => "100", :longitude => "100"
        response.should be_success
        response.header['Content-Type'].should include 'application/json'
      end
      it "returns http fail without paramater" do
        get 'list_restaurants'
        response.should_not be_success
      end
    end
    context "when not logged in" do
      before do
        session[:user_id] = nil
      end
      it "returns error" do
        get 'list_restaurants', :latitude => "100", :longitude => "100"
        response.code.should == '401'  # unauthorized
      end
    end
  end

  describe "GET 'show_restaurant'" do
    before do
      session[:user_id] = @user.id
    end
    it "returns json data" do
      # ハイライト
      get 'show_restaurant', :reference => 'CnRmAAAAIMjWjpsbOXwUtC9UCfC6t63jISD3W5IYTvlZQGLJOyvwJFu27KWoYnaaeeJGzngzpIwpkG6Ri2YYRA_PWUDeKxDoJxSP9VOAT4dLyp5ecGULunavUD1btkhGDTmk1KUtKNk9vfI6bfxUnhZRGZznSRIQkDRzBCkHc6I_kiHO4BquTRoUP1XDOT3pTBA-YRQ7bLOj9mZ4kcM'
      response.should be_success
      response.header['Content-Type'].should include 'application/json'
    end
  end

end

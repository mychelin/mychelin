require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should redirect_to(:signin)
    end
  end

end

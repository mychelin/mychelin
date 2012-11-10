require "spec_helper"

describe ServiceController do
  describe "routing" do
    it "routes to #list_restaurant" do
      get("/service/restaurants").should route_to("service#list_restaurants")
    end

    it "routes to #show_restaurant" do
      get("/service/restaurant/xxxxxx").should route_to("service#show_restaurant", :reference => 'xxxxxx')
    end
  end
end

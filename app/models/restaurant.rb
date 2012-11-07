class Restaurant < ActiveRecord::Base
  attr_accessible :address, :business_hour, :capacity, :credit, :holiday, :location, :name, :parking, :tel, :url
end

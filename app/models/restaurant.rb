# -*- coding: utf-8 -*-
class Restaurant < ActiveRecord::Base
  attr_accessible :address, :business_hour, :capacity, :credit, :holiday, :location, :name, :parking, :tel, :url
  validates :tel, :format => { :with => /(\d|-)+/ }

  def self.search(latitude, longitude)
    # 緯度(latitude) 1秒 = 約30.8m
    # 経度(longitude)1秒 = 約25.1m
    # これは日本の場合。場所によって大きく違う
    all.find_all do |restaurant|
      lat, lng = restaurant.location.split ','

      # all restaurants within 500 from given point
      Math.hypot((latitude.to_f - lat.to_f)  * 3600 * 30.8,
                 (longitude.to_f - lng.to_f) * 3600 * 25.1) <  500
    end
  end
end

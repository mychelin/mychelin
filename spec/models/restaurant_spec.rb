# -*- coding: utf-8 -*-
require 'spec_helper'

describe Restaurant do
  before do
    @loc_sanjo = { lat:'35.01093301313473', lng:'135.76820066137702' }

    @restaurant_kyoto = [ create(:restaurant, name: 'がんこ 高瀬川二条苑',   location: '35.012738,135.770791'),
                          create(:restaurant, name: 'スターバックスコーヒー京都三条大橋店', location: '35.009214,135.771207')]
    @restaurant_shiga = [ create(:restaurant, name: '本格手打ち蕎麦 文久蔵', location: '35.256765,136.258157') ]
  end

  describe '.search' do
    it 'receive latitude and longitude, then return restaurants around there' do
      result = Restaurant.search(@loc_sanjo[:lat], @loc_sanjo[:lng])
      result.should include @restaurant_kyoto.first
      result.should_not include @restaurant_shiga.first
    end
  end

end

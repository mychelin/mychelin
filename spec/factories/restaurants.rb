# -*- encoding: utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :restaurant do
    name "restaurant_name"
    tel "0000112222"
    url "http://example.com"
    location"10.0000,20.0000"
  end

  factory :restdata, :class => Restaurant do
    name "aaaa"
    tel "080111122222"
    url "http://test.example.com"
    location "10,20"
  end

  factory :restdata2, :class => Restaurant do
    name "良い感じのバー すごい酒置いてる"
    tel "080111122222"
    url "http://test.example.com"
    location "hoge2"
  end

  sequence(:random_string) {|n| LoremIpsum.generate}

  factory :random_data, :class => Restaurant do
    name generate(:random_string)
    tel generate(:random_string)
    url generate(:random_string)
    location generate(:random_string)
  end

end


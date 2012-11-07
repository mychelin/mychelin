# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :restaurant do
    name "MyString"
    tel "MyString"
    url "MyString"
    location "MyString"
    address "MyString"
    business_hour "MyText"
    holiday "MyText"
    capacity 1
    credit false
    parking false
  end
end

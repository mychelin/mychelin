# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    comment "MyText"
    photo ""
    star 1
    restarurant nil
    user nil
  end
end

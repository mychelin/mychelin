# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user, :class => User do
    provider "facebook"
    uid "12345"
    name "Bob"
  end

  factory :people, :class => User do
    provider "facebook"
    id "12345"
    uid "12345"
    email "test"
    name ""
  end

  factory :emperor, :class => User do
    provider "facebook"
    uid "12345"
    name "Bob"
    email "test"
    role "admin"
  end
end

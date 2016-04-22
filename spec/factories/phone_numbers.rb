require 'faker'

FactoryGirl.define do
  factory :phone_number do
    country_code    { 1 }
    phone_number    { Faker::PhoneNumber.phone_number }
  end
end

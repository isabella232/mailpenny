require 'faker'

FactoryGirl.define do
  factory :user do
    username    { Faker::Internet.user_name }
    email       { Faker::Internet.email }
    password 'password'
    password_confirmation 'password'
    confirmed_at Date.today

    trait :charitable do
      charitable true
    end
  end
end

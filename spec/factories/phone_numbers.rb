require 'faker'

FactoryGirl.define do
  factory :phone_number do
    country_code '1'
    phone_number 'phone_number: "415-890-4346"'
    verification_method 'sms'

    trait :call do
      verification_method 'call'
    end
  end
end

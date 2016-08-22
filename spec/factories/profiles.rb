# == Schema Information
#
# Table name: profiles
#
#  id               :integer          not null, primary key
#  name             :string
#  bio              :text
#  work_company     :string
#  work_title       :string
#  location         :string
#  twitter_username :string
#  rate_email       :decimal(, )      default(0.0), not null
#  rate_sms         :decimal(, )      default(0.0), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer
#

FactoryGirl.define do
  factory :profile do
    # profile settings
    name { Faker::Name.name }
    bio { Faker::Lorem.sentence 3, true, 12 }
    work_company { Faker::Company.name }
    work_title { Faker::Name.title }
    location { Faker::Address.city }
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  username               :string
#  bio                    :text
#  work_company           :string
#  work_title             :string
#  location               :string
#  twitter_username       :string
#  cellphone_number       :string
#  rate_email             :decimal(, )
#  rate_sms               :decimal(, )
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'restricted_usernames'

# People using the app
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable, :lockable,
         :timeoutable

  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: /\A[a-zA-Z0-9_.-]+\Z/ },
            exclusion: {
              in: RestricedUsernamesIdentifier.new.initial_path_segments,
              message: 'Username unavailable'
            }

  validates :rate_email,
            numericality: { greater_than_or_equal_to: 0 }

  validates :rate_sms,
            numericality: { greater_than_or_equal_to: 0 }

  has_one :account

  before_validation :set_defaults
  before_create :build_default_account

  private

  def set_defaults
    self.rate_email ||= 0
    self.rate_sms ||= 0
  end

  def build_default_account
    build_account account_type: :user
    true
  end
end

# The humans on the system
class Human < ActiveRecord::Base
  require 'rails_restricted_usernames'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable,
         :confirmable
  validates :username, presence: true, uniqueness: true
  validates_exclusion_of :username, in: RestricedUsernamesIdentifier.new.initial_path_segments,
                                    message: 'That username is unavailable'
  has_one :account
  has_one :profile
  has_one :reward
  has_one :social_medium
  has_many :ccards
  has_many :emails
  has_many :phones
  has_many :whitelists
  has_many :user_emails
  before_create :build_default_profile
  before_create :build_default_account
  before_create :build_default_profile
  before_create :build_default_reward
  before_create :build_default_social_medium

  # The money movement
  def fee
    fee = BigDecimal('0.5')
    fee = BigDecimal('0.2') if charitable
    fee
  end

  private

  def build_default_reward
    build_reward
    true
  end

  def build_default_social_medium
    build_social_medium
    true
  end

  def build_default_account
    build_account
    true
  end

  def build_default_profile
    build_profile
    true
  end
end

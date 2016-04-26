# The humans on the system
class User < ActiveRecord::Base
  require 'rails_restricted_usernames'
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable,
         :confirmable
  validates :username, presence: true, uniqueness: true
  validates_exclusion_of :username, in: RestricedUsernamesIdentifier.new.initial_path_segments,
                                    message: 'That username is unavailable'
  validates :fee_email, numericality: { less_than_or_equal_to: 0 }
  validates :fee_sms, numericality: { less_than_or_equal_to: 0 }

  has_one :account
  has_one :profile
  has_one :twitter_account
  has_one :phone_number
  has_many :ccards
  before_create :build_default_profile
  before_create :build_default_account
  before_create :generate_stripe_id

  # The money movement
  def fee
    fee = BigDecimal('0.5')
    fee = BigDecimal('0.2') if charitable
    fee
  end

  private

  def build_default_account
    build_account
    true
  end

  def build_default_profile
    build_profile
    true
  end

  def generate_stripe_id
    stripe = Stripe::Customer.create(
      description: "Username: #{username}",
      email: email
    )
    self.stripe_id = stripe.id
  end
end

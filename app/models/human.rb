# The humans on the system
class Human < ActiveRecord::Base
  require 'rails_routes_recognizer'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable,
         :confirmable
  validates :username, presence: true, uniqueness: true
  validates_exclusion_of :username, in: RouteRecognizer.new.initial_path_segments,
                                    message: 'That username is unavailable'

  has_one :account
  before_create :build_default_account
  # The money movement
  def fee
    fee = BigDecimal('0.5')
    fee = BigDecimal('0.2') if charitable
    fee
  end

  def deposit(args)
    # add new money from outside
    args.slice!(:amount,
                :currency,
                :ref,
                :meta,
                :stripe_charge_id
               )
    # this is a deposit
    args[:deposit] = true
    add_ledger_entry args
  end

  def withdraw(args)
    # take money out of the system
    args.slice!(:from,
                :amount,
                :currency,
                :ref,
                :meta
               )
    # this is a withdrawal
    args[:withdrawal] = true
    add_ledger_entry args
  end

  def pay(args)
    # Make a payment to someone
    args.slice!(:to,
                :amount,
                :ref,
                :meta
               )
    # this is a payment
    args[:payment] = true
    args[:from] = self
    add_ledger_entry args
  end

  private

  def build_default_account
    build_account
    true
  end

  def add_ledger_entry(args)
    entry = args.slice(
      :amount,
      :currency,
      :payment,
      :deposit,
      :withdrawal,
      :ref,
      :meta,
      :stripe_charge_id
    )

    # take it from my account if it's a withdrawal
    from = account if entry[:withdrawal] || entry[:deposit]
    # take it to from the deposit account if it is a deposit
    from = Account.find_by meta_name: 'deposit' if entry[:deposit]
    #  take it from my the person if this is a payment
    from = args[:from].account if entry[:payment]
    # make sure the account is not nil
    fail if from.nil?

    # send to my own account if it's a deposit
    to = account if entry[:deposit]
    # send it to the withdrawal account if it is a withdrawal
    to = Account.find_by meta_name: 'withdrawal' if entry[:withdrawal]
    # send to the person if this is a payment
    to = args[:to].account if entry[:payment]
    # make sure it's going to someone
    fail if to.nil?

    if entry[:payment]
      fee_entry = entry
      fee_amount = to.human.fee * BigDecimal(entry[:amount])
      fee_entry[:amount] = fee_amount
      fee_entry[:from] = to
      fee_entry[:to] = Account.find_by(meta_name: 'revenue')
    end

    entry[:currency] = 'usd' if args[:currency].nil?
    entry[:from_id] = from.id unless from.nil?
    entry[:to_id] = to.id unless to.nil?

    Human.transaction do
      Ledger.create(entry)
      to.increment!('balance', entry[:amount])
      from.decrement!('balance', entry[:amount])

      if entry[:payment]
        Ledger.create(fee_entry)
        fee_entry[:from].decrement!('balance', fee_entry[:amount])
        fee_entry[:to].increment!('balance', fee_entry[:amount])
      end
    end
  end
end

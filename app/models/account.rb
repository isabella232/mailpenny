class Account < ActiveRecord::Base
  belongs_to :user
  has_many :ledgers

  def deposit(args)
    # add new money from outside
    args.slice!(:amount,
                :stripe_charge_id,
                :currency,
                :ref,
                :meta
               )
    # this is a deposit
    args[:type_deposit] = true
    # deposits go into our own accounts
    args[:to] = self
    # deposits come from the deposit account
    args[:from] = Account.find_by(meta_name: 'deposit')
    # raise an error if there's no deposit account
    fail "Could not find 'deposit' account. Has the DB been seeded?" if
    args[:from].nil?
    # process the transaction
    process_transaction args
  end

  def withdraw(args)
    # take money out of the system
    args.slice!(:amount,
                :currency,
                :ref,
                :meta
               )
    # this is a withdrawal
    args[:type_withdrawal] = true
    # withdrawals are taken from self
    args[:from] = self
    # withdrawals go to the withdrawal account
    args[:to] = Account.find_by(meta_name: 'withdrawal')
    # raise an error if there's no withdrawal account
    fail "Could not find 'withdrawal' account. Has the DB been seeded?" if
    args[:to].nil?
    # process the transaction
    process_transaction args
  end

  def transfer(args)
    # Make a payment to someone
    args.slice!(:to,
                :amount,
                :ref,
                :meta
               )
    # this is a payment
    args[:type_transfer] = true
    # payments come from self
    args[:from] = self
    # raise an error if it's not being sent to anyone valid
    fail 'You must transfer to a valid user' if
    args[:to].nil? || args[:to].valid?
    # process the transaction
    process_transaction args
  end

  private

  def process_transaction(args)
    entry = args.slice(
      :amount,
      :from,
      :to,
      :currency,
      :type_transfer,
      :type_deposit,
      :type_withdrawal,
      :ref,
      :meta,
      :stripe_charge_id
    )
    # default currency is usd
    entry[:currency] = 'usd' if args[:currency].nil?
    # create a fee entry if required
    fee_entry = create_fee_entry(args) if args[:type_transfer]
    # create the transaction
    create_transaction(entry, fee_entry)
  end

  def create_transaction(entry, fee_entry = nil)
    Account.transaction do
      # create the entry
      entry_made = Ledger.create(entry)
      # increase the recepient's balance
      entry[:to].increment!('balance', entry[:amount])
      # decrease the sender's balance
      entry[:from].decrement!('balance', entry[:amount])

      fail 'Insufficient funds' if
      entry[:from].balance < 0 && entry[:from].meta? == false

      if fee_entry
        # add the ref id
        fee_entry[:ref] = entry_made[:id]
        # create the fee entry
        Ledger.create(fee_entry)
        # deduct the fee being charged from the balance
        fee_entry[:from].decrement!('balance', fee_entry[:amount])
        # add it to the fee account
        fee_entry[:to].increment!('balance', fee_entry[:amount])
      end
    end
  end

  def create_fee_entry(args)
    fee_entry = args.slice(:amount,
                            :from,
                            :to,
                            :currency,
                            )
    fee_entry[:amount] = args[:to].human.fee * BigDecimal(args[:amount])
    fee_entry[:from] = args[:to]
    fee_entry[:to] = Account.find_by(meta_name: 'revenue')
    fee_entry[:type_fee] = true
    fee_entry
  end
end

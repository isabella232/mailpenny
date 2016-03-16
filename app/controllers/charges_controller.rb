# The stripe charges controller
class ChargesController < ApplicationController
  before_action :set_user_if_in_session

  def new
    amount = params[:amount].to_i
    @amount = 500
    @amount = amount unless amount.nil? || amount < 500
  end

  def create
    # Amount in cents
    @amount = params[:amount].to_i
    @email = params[:stripeEmail]
    @token = params[:stripeToken]
    customer = Stripe::Customer.create(
      email: @email,
      source: @token
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: "#{@amount} topup for #{@email}",
      currency: 'usd'
    )

    deposit to: @current_user, amount: @amount, stripe_charge_id: charge.id

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  private

  def deposit(args)
    args.slice!(:to,
                :amount,
                :currency,
                :ref,
                :meta,
                :stripe_charge_id
               )
    args[:deposit] = true
    add_ledger_entry args
  end

  def withdraw(args)
    args.slice!(:from,
                :amount,
                :currency,
                :ref,
                :meta
               )
    args[:withdrawal] = true
    add_ledger_entry args
  end

  def make_payment(args)
    args.slice!(:from,
                :to,
                :amount,
                :currency,
                :ref,
                :meta
               )
    args[:payment] = true
    add_ledger_entry args
  end
end

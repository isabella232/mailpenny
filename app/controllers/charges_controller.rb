# The stripe charges controller
class ChargesController < ApplicationController
  before_action :authenticate_human!

  def new
    amount = params[:amount].to_i
    @amount = 500
    @amount = amount unless amount.nil? || amount < 500
  end

  def create
    # Amount in cents
    @amount = params[:amount].to_f
    @amount = @amount.to_f
    @amount = @amount/100.to_f
    @email = params[:stripeEmail]
    @token = params[:stripeToken]
    customer = Stripe::Customer.create(
      email: @email,
      source: @token
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: (@amount.to_i * 100),
      description: "#{@amount} topup for #{@email}",
      currency: 'usd'
    )

    current_human.account.deposit amount: @amount, stripe_charge_id: charge.id

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
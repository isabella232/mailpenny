# The stripe charges controller
class ChargesController < ApplicationController
  def new
    amount = params[:amount].to_i
    @amount = 500
    @amount = amount unless amount.nil? || amount < 500

  end

  def create
    # Amount in cents
    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'usd'
    )

    byebug

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end

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
    @amount = params[:amount]
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

    byebug

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end

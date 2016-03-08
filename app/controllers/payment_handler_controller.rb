#   This controller handles charging payments, logging them, and adding them
# to the user's account
class PaymentHandlerController < ApplicationController
  # adds the card to the DB
  def add_card
    setup_stripe
    # Get the credit card details submitted by the form
    user_id = session[:user_id].to_i
    token = params[:stripeToken]

    card_string = params[:cardDetails]
    card = card_string_to_card card_string

    add_card_by_user_id card, user_id
    create_customer_with_token token

    redirect_to :billing
  end

  private

  def setup_stripe
    Stripe.api_key = 'sk_test_FFIHFNSi40UgAnEO9HxBbaPr'
  end

  def add_card_by_user_id(card, user_id)
    User.findBy(id: user_id).card << card
  end

  def card_string_to_card(card_string)
    card = JSON.parse(card_string)
    card.slice!(
      :address_city,
      :address_country,
      :address_line1,
      :address_line2,
      :address_state,
      :address_zip,
      :brand,
      :exp_month,
      :exp_year,
      :funding,
      :last4
    )
    Ccard.new card
  end

  def create_customer_with_token(token)
    Stripe::Customer.create(
      source: token,
      description: 'Example customer'
    )
  end
end

#   This controller handles charging payments, logging them, and adding them
# to the user's account
class PaymentHandlerController < ApplicationController
  before_action :set_user_if_in_session

  def charge_primary_card
    amount = params[:chargeAmount]
    card = find_primary_card_by_user @user

    charge_card card: card, amount: amount
  end
  # adds the card to the DB

  def setup_stripe
    # Get the credit card details submitted by the form
    user_id = session[:user_id].to_i
    token = params[:stripeToken]
    card_string = params[:cardDetails]

    user = find_user_by_id user_id
    card = card_string_to_card card_string

    user.card = card

    add_card_by_user_id card, user_id
    customer = create_customer_with_token token

    user.save

    redirect_to :billing
  end

  private

  def setup_stripe
    Stripe.api_key = 'sk_test_FFIHFNSi40UgAnEO9HxBbaPr'
  end

  def find_user_by_id(_card, user_id)
    User.findBy(id: user_id)
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

class PaypalController < ApplicationController
  before_action :authenticate_user!

  # GET /paypal/client_token
  def client_token
    render json: { token: gateway.client_token.generate }
  end

  # POST /paypal/checkout
  def checkout
    nonce = params[:payment_method_nonce]

    result = gateway.transaction.sale(
      amount: '10.00',
      merchant_account_id: 'USD',
      payment_method_nonce: nonce,
      order_id: 'Mapped to PayPal Invoice Number',
      shipping: {
        first_name: 'Jen',
        last_name: 'Smith',
        company: 'Braintree',
        street_address: '1 E 1st St',
        extended_address: 'Suite 403',
        locality: 'Bartlett',
        region: 'IL',
        postal_code: '60103',
        country_code_alpha2: 'US'
      },
      options: {
        paypal: {
          custom_field: 'PayPal custom field',
          description: 'Description for PayPal email receipt'
        }
      }
    )
    if result.success?
      render text: "Success ID: #{result.transaction.id}"
    else
      render text: result.message
    end
  end

  private

    def gateway
      Braintree::Gateway.new(
        access_token: 'access_token$sandbox$pdpmtkty658pdc5y$24487e7a272c922a9042912af53498e5'
      )
    end
end

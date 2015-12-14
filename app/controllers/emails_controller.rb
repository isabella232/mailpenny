# This class is to listen and send emails
class EmailsController < ApplicationController
  def recieve
    email = Email.new
    email.from = params['sender']
    email.to = params['recipient']
    email.subject = params['subject']
    email.body = params['body-plain']
    email.save

    mg_client = Mailgun::Client.new 'key-5b10854538566549aac6724aaa54dabe'

    # Define your message parameters
    message_params = { from: 'waleed@gmail.com',
                       to: email.from,
                       subject: 'Coinbase address',
                       text: 'Pay the amount of reward in BTC here:XXXXXXXXXXX' }
    # Send your message through the client
    mg_client.send_message 'sandbox050314df0b744b97beecf2742a588852.mailgun.org', message_params

    render template: 'emails/recieve'
  end

  def welcome
  end

  def create_address
    logger.debug('i am in the create address')
    require 'coinbase/wallet'
    client = Coinbase::Wallet::Client.new(api_key: 'eNuQ5NQy3FBar2Dn', api_secret: 'wJs4iiaXFkHaFUSsnlERxkfeLlge6fHV')
    account = client.create_account(name: 'mynewaccount1')
    address = account.create_address(callback_url: 'https://floating-plains-7200.herokuapp.com/payment_recieved')
    render json: address.to_s
  end
  def payment_recieved
    render json: params.to_s
  end
end

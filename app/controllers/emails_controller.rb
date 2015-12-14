# This class is to listen and send emails
class EmailsController < ApplicationController
  def recieve
    email = Email.new
    email.from = params['sender']
    email.to = params['recipient']
    email.subject = params['subject']
    email.body = params['body-plain']
    email.save
    logger.debug(params.to_s)
    mg_client = Mailgun::Client.new 'key-5b10854538566549aac6724aaa54dabe'
    address = create_address
    btc_address = address['address']
    # Define your message parameters
    message_params = { from: 'waleed@mailman.ninja',
                       to: email.from,
                       subject: 'Coinbase address',
                       text: 'Pay the amount of reward in BTC at this address :'+btc_address }
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
    return address
  end
  def payment_recieved
    logger.debug(params.to_s)
    mg_client = Mailgun::Client.new 'key-5b10854538566549aac6724aaa54dabe'

    message_params = { from: 'waleed@mailman.ninja',
                       to: 'waleedsulehria@gmail.com',
                       subject: 'Coinbase address',
                       text: params.to_s }
   mg_client.send_message 'sandbox050314df0b744b97beecf2742a588852.mailgun.org', message_params

    render json: params.to_s
  end
end

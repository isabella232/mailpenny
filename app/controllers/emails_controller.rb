# This class is to listen and send emails
class EmailsController < ApplicationController
  def recieve

      email = Email.find_by_to(params['from'].to_s)

      if(email.present?)
        if(params['subject'].to_s.include? 'Re: ')
          str = params['subject'].to_s.slice 'Re: '
          if(str == email.subject)
            transaction = Transaction.find_by_email_id(email.id)
            to = email.to
            amount = transaction.amount.to_s
            send_money('b2411493-3d92-5c11-b6ad-aee0a0a446a7',amount,to)
          end
        end
      else
        user = User.find_by_email(params['from'])
        if(user.present?)
          email = Email.new
          email.from = params['from']
          email.to = params['To']
          email.subject = params['subject']
          email.body = params['body-plain']
          account = find_account(user.coinbase_id.to_s);
          address = create_address(account)
          btc_address = address['address']
          email.user = user
          email.save
          transaction = Transaction.new
          transaction.btc_address = btc_address.to_s
          transaction.email = email
          transaction.user = user
          transaction.save

          send_email email.from,"Pay the amount of reward in BTC at this address :"+btc_address,'BTC address'
        else
          email = Email.new
          email.from = params['from']
          email.to = params['To']
          email.subject = params['subject']
          email.body = params['body-plain']
          user = User.new
          user.email = email.from
          user.coinbase_id = '114b91b8-2ecc-5304-b49b-7a0ac970a9b7'
          account = find_account(user.coinbase_id.to_s);
          user.coinbase_id = account['id']
          address = create_address(account)
          btc_address = address['address']
          email.save
          user.save
          transaction = Transaction.new
          transaction.btc_address = btc_address.to_s
          transaction.email = email
          transaction.user = user
          transaction.save
          send_email email.from,"Pay the amount of reward in BTC at this address :"+btc_address,'BTC address'
        end
      end
      render template: 'emails/recieve'
  end

  def welcome
  end
  def find_account(id)
    require 'coinbase/wallet'
    client = Coinbase::Wallet::Client.new(api_key: 'eNuQ5NQy3FBar2Dn', api_secret: 'wJs4iiaXFkHaFUSsnlERxkfeLlge6fHV')
    account = client.account(id)
    return account
  end
  def create_account
    require 'coinbase/wallet'
    client = Coinbase::Wallet::Client.new(api_key: 'eNuQ5NQy3FBar2Dn', api_secret: 'wJs4iiaXFkHaFUSsnlERxkfeLlge6fHV')
    account = client.create_account(name: 'mynewaccount1')
    return account
  end
  def create_address(account)
    address = account.create_address(callback_url: 'https://floating-plains-7200.herokuapp.com/emails/payment_recieved')
    return address
  end
  def payment_recieved
    address = params['address']
    amount = params['amount']
    transaction = Transaction.find_by_btc_address(address.to_s)
    transaction.amount = amount.to_f
    transaction.to = 'mailman'
    email = transaction.email;
    transaction.save
    send_email email.to, 'Hurry up! Reply to this Email in 48 hours and get ' + amount.to_s + ' BTC',email.subject
    render template: 'emails/recieve'
  end


  def send_email(to,text,subject)
    mg_client = Mailgun::Client.new 'key-5b10854538566549aac6724aaa54dabe'
    message_params = { from: 'user <user@sandbox050314df0b744b97beecf2742a588852.mailgun.org>',
                       to: to,
                       subject: subject,
                       text:  text }
    # Send your message through the client
    mg_client.send_message 'sandbox050314df0b744b97beecf2742a588852.mailgun.org', message_params
  end
  def send_money(id,amount,to)
    require 'coinbase/wallet'
    client = Coinbase::Wallet::Client.new(api_key: 'eNuQ5NQy3FBar2Dn', api_secret: 'wJs4iiaXFkHaFUSsnlERxkfeLlge6fHV')
    client.send(id.to_s,{to: to.to_s, amount: amount.to_s, currency: 'BTC'})

  end
end

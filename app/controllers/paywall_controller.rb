class PaywallController < ApplicationController

  def login

  end

  def register

    @notif = "";
    if(params.has_key?'email')
      user = User.new;
      cred = Credential.new;
      user.email = params['email']
      cred.username = user.email.split('@').first
      cred.password = params['password']
      user.credential = cred;
      user.save;
      cred.save;
      @notif = "Done!!!!"
      render template: 'paywall/register'
    else
      @notif="";
      render template: 'paywall/register'
    end
  end

  def recieve
    email = Email.new
    email.to = params['To'].to_s;
    email.subject = params['subject'].to_s;
    email.from = params['from'].to_s;
    email.body = params['body-plain'].to_s;
    #email.header = params['message-headers'].to_s;
    email.to = email.to[/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i];
    email.from = email.from[/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i];
    username = email.to.split('@').first;
    email.save
    cred = Credential.find_by_username(username);
    if(cred.present?)
      user =  User.find(cred.user_id);
      user.emails << email
      user.save
      user.coinbase_id = '114b91b8-2ecc-5304-b49b-7a0ac970a9b7'
      account = find_account(user.coinbase_id.to_s);
      address = create_address(account)
      btc_address = address['address']
      send_email(email.from.to_s,"Hey i am Using Paywall. Pay the 1 mBTC on the given BTC address to push your email forward :"+btc_address,email.subject);
      trans = Transaction.new;
      trans.btc_address =btc_address;
      trans.to = "mailman";
      trans.amount = 0.0001;
      trans.status = "pending";
      user.transactions << trans;
      trans.email = email;
      trans.save;
      email.save;
    end
    render text: "It is Done";
  end

  def find_account(id)
    require 'coinbase/wallet'
    client = Coinbase::Wallet::Client.new(api_key: 'eNuQ5NQy3FBar2Dn', api_secret: 'wJs4iiaXFkHaFUSsnlERxkfeLlge6fHV')
    account = client.account(id)
    return account
  end
  def create_address(account)
    address = account.create_address(callback_url: 'https://floating-plains-7200.herokuapp.com/paywall/payment_recieved')
    return address
  end
  def send_email(to,text,subject)
    mg_client = Mailgun::Client.new 'key-bcdc4d42e9fa4892dd98272424ac29d7'
    message_params = { from: 'user <user@mailman.ninja>',
                       to: to,
                       subject: subject,
                       text:  text }
    # Send your message through the client
    mg_client.send_message 'mailman.ninja', message_params
  end
  def payment_recieved
    address = params['address'];
    transaction = Transaction.find_by_btc_address(address.to_s)
    email = transaction.email;
    user = transaction.user;
    em_addr = user.email.to_s;
    send_email(em_addr,"This emails is from "+email.from+'\n'+email.body,email.subject);
    render text: "Mail sent";
  end
end
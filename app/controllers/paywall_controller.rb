class PaywallController < ApplicationController
  require 'securerandom'

  def login
    if(params.has_key?'email')
      user= User.find_by_email(params['email'])
      if(user.present?)
        cred= user.credential
        if(cred.present?)
          if(cred.password== params['password'])
            session[:email] = user.email;
            redirect_to :action => 'home'
          end
        end
      end
    end
  end

  def home
    email = session[:email]
    user = User.find_by_email(email)
    @mail = user.email
  end
  def settings
    email = session['email'];
    user = User.find_by_email(email)
    @mail = user.email
  end
  def logout
    reset_session
    redirect_to :action => 'login'
  end
  def transactions
    email = session['email'];
    user = User.find_by_email(email)
    @mail = user.email
  end
  def register
    @notif = "";
    if(params.has_key?'email');
      user = User.new;
      cred = Credential.new;
      user.email = params['email'];
      flt = params['reward'];
      flt = flt.to_f;
      user.reward = flt;
      cred.username = user.email.split('@').first;
      cred.password = SecureRandom.base64(10);
      user.credential = cred;
      user.save;
      cred.save;
      send_email(user.email,"You Password for mailman account : "+cred.password,"Mailman Credentials");
      redirect_to :action => 'login';
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
    #email.to = email.to[/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i];
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
      qr(btc_address)
      send_email_att(email.to,email.from.to_s,"Hey i am Using Paywall. Pay the 1 mBTC on the given BTC address or Scan the QR code in attachment to push your email forward otherwise it will stay in my spam folder:"+btc_address,email.subject,btc_address);
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

  def qr(address)
    require 'rqrcode_png'
    qr = RQRCode::QRCode.new( address, :size => 4, :level => :h )
    png = qr.to_img                                             # returns an instance of ChunkyPNG
    address = "tmp/"+address+".png"
    png.resize(180, 180).save(address)
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
    message_params = { from: 'mailman <mailman@mailman.ninja>',
                       to: to,
                       subject: subject,
                       text:  text }
    # Send your message through the client
    mg_client.send_message 'mailman.ninja', message_params
  end
  def send_email_att(from,to,text,subject,address)
    mg_client = Mailgun::Client.new 'key-bcdc4d42e9fa4892dd98272424ac29d7'
    message_params = { from: from,
                       to: to,
                       subject: subject,
                       text:  text ,
                       attachment: File.new(File.join("tmp", address+'.png')),
                       multipart: true }
    # Send your message through the client
    mg_client.send_message 'mailman.ninja', message_params
  end
  def send_complex_message
    mg_client = Mailgun::Client.new 'key-bcdc4d42e9fa4892dd98272424ac29d7'
    message_params = { from: 'user <user@mailman.ninja>',
                       to: 'waleed@payload.tech',
                       subject: 'hey  ',
                       text:  'Hello' ,
                       attachment: File.new(File.join("tmp", 'really_cool_qr_image.png')),
                       multipart: true }
    # Send your message through the client
    mg_client.send_message 'mailman.ninja', message_params
    redirect_to :action => 'login'
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
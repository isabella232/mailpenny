class PaywallController < ApplicationController
  def profile
    @current = false;
    id = params[:username]
    @user1  = current_human
    @user  = Human.find_by_username(id)

    if(@user1 === @user)
      @current = true;
    end
    redirect_to action: :register if @user.nil?
  end
  def login
    if(params.has_key?'email')
      user= User.find_by_email(params['email'])
      if(user.present?)
        cred= user.credential
        if(cred.present?)
          if(cred.password== params['password'])
            session[:user_id] = user.id;
            redirect_to :action => 'settings'
          end
        end
      end
    end
  end
  def home
    id = session[:user_id].to_i;
    if(id===0)
      redirect_to :action => 'login'
    else
    user = User.find(id);
    @mail = user.email
    end
  end
  def whitelist
    @user= User.new
    id = session[:user_id].to_i;
    @id=id
    if(id===0)
      redirect_to :action => 'login'
    else
      @user = User.find(id);
      @mail = @user.email
    end
  end
  def whitelist_delete
    logger.debug params.inspect
    @id = params['whitelist']['id']
    Whitelist.all.destroy(@id)
    respond_to do |format|
      format.js   { render :template => 'paywall/delete_list.js.erb' }
    end
  end
  def whitelist_add
    logger.debug params.inspect
    email = params['whitelist']['email'];
    @w = Whitelist.new
    @w.email = email;
    id = params['whitelist']['id'].to_i;
    user = User.find(id)
    user.whitelists << @w
    @w.save
    user.save
    respond_to do |format|
      format.js   { render :template => 'paywall/add_list.js.erb' }
    end
  end
  def settings
    if human_signed_in?
      @user = current_human
      @mail = current_human.email
    end
  end
  def logout
    reset_session
    redirect_to :action => 'login'
  end

  def update_user
    id = params['user']['id'].to_i;
    @user = User.find(id)
    #@user.email = params['user']['email']
    #@user.BTC_address = params['user']['name']
    @user.phone = params['user']['phone'].to_s;
    @user.reward.email = params['user']['reward'].to_f;
    @user.save
    respond_to do |format|
      format.js   { render :template => 'paywall/user_update' }
    end
  end
  def transactions
    id = session[:user_id].to_i;
    if(id===0)
      redirect_to :action => 'login'
    else
      @user = User.find(id);
      @mail = @user.email
    end
  end
  def register
    @notif = "";
    if(params.has_key?'email')
      user = User.new
      cred = Credential.new
      user.email = params['email']
      flt = params['reward']
      flt = flt.to_i
      cred.username = params['username']
      cred.activated = 0
      flag = cred.save
      if(flag===true)
        user.credential = cred;
        flag1 = user.save;
        if(flag1===true)
          url = "http://themailman.io/setpassword?id="+cred.id.to_s;
          Notifications.verify(user: user, link: url).deliver_now
          flash[:success] = "An email has been sent to your inbox!"
        else
          flash[:warning] = "An account with this email already exists";
          cred.destroy
        end
      else
        @message = "Username not available"
      end
     else
      @notif="";
      render template: 'paywall/register'
    end
  end
  def setpassword
    if(params.has_key?'id')
      id = params['id'].to_i;
      cred = Credential.find(id)
      if(cred.present? && cred.activated===0 )
        @cred = cred;
      else
        redirect_to :action => 'login'
      end
    else
      redirect_to :action => 'login'
    end
  end
  def activate
      if(params.has_key?'password')
          pass = params['password'];
          id = params['id'].to_i;
          cred = Credential.find(id)
        if(cred.present?)
          prof = Profile.new
          prof.first_name = params['firstname'];
          prof.last_name = params['lastname'];
          prof.location = params['location'];
          prof.save;
          user1 = cred.user;
          user1.profile = prof;
          rew = Reward.new
          rew.email=0.10;
          rew.call=0.00;
          rew.sms=0.00;
          user1.reward = rew;
          user1.save;
          cred.activated=1;
          cred.password=pass;
          cred.save
          redirect_to :action => 'login'
          email = cred.user.email.to_s;
          send_email(email,"Hey,"+cred.username+"@themailman.io is your public email address, You can use it anywhere publicaly like your regular email i-e on Facebook , Instagram or any where. All the non spam messages will be delivered to your regular inbox. Thank you for using Mailman","Thanks,We love you");
        end
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
    user = Human.find_by_username(username)
    if(user.present?)
      user.emails<< email;
      user.save
    end
   =begin cred = Credential.find_by_username(username);
    if(cred.present?)
      user =  User.find(cred.user_id);
      user.emails << email
      user.save
      wlist = user.whitelists.find_by_email(email.from);
      if(wlist.present?)
        send_email(user.email,"This emails is from "+email.from+''+email.body,email.subject);
        render text: "It is done"
        return
      end
      user.coinbase_id = '114b91b8-2ecc-5304-b49b-7a0ac970a9b7'
      account = find_account(user.coinbase_id.to_s);
      address = create_address(account)
      btc_address = address['address']
      qr(btc_address)
      send_email_att(email.to,email.from.to_s,"Hey i am Using Mailman. Pay the"+ user.reward.email.to_s+" on the given BTC address or Scan the QR code in attachment to push your email forward otherwise it will stay in my spam folder:"+btc_address,email.subject,btc_address);
      trans = Transaction.new;
      trans.from = email.from;
      trans.btc_address = btc_address;
      trans.to = "mailman";
      trans.amount = user.reward.email;
      trans.status = "pending";
      user.transactions << trans;
      trans.email = email;
      trans.save;
      email.save;
    end
    render text: "It is Done";
  =end
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
    address = account.create_address(callback_url: 'https://themailman.io/payment_recieved')
    return address
  end
  def send_email(to,text,subject)
    mg_client = Mailgun::Client.new 'key-69d530fcc92a526320f504e0b8b963a7'
    message_params = { from: 'mailman <mailman@themailman.io>',
                       to: to,
                       subject: subject,
                       text:  text }
    # Send your message through the client
    mg_client.send_message 'themailman.io', message_params
  end
  def send_email_from_user(to,from,text,subject)
    mg_client = Mailgun::Client.new 'key-69d530fcc92a526320f504e0b8b963a7'
    message_params = { from: from,
                       to: to,
                       subject: subject,
                       text:  text }
    # Send your message through the client
    mg_client.send_message 'themailman.io', message_params
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
    mg_client.send_message 'themailman.io', message_params
  end
  def send_complex_message
    mg_client = Mailgun::Client.new 'key-bcdc4d42e9fa4892dd98272424ac29d7'
    message_params = { from: 'user <user@themailman.io>',
                       to: 'waleed@payload.tech',
                       subject: 'hey  ',
                       text:  'Hello' ,
                       attachment: File.new(File.join("tmp", 'really_cool_qr_image.png')),
                       multipart: true }
    # Send your message through the client
    mg_client.send_message 'themailman.io', message_params
    redirect_to :action => 'login'
  end

  def payment_recieved
    address = params['address'];
    transaction = Transaction.find_by_btc_address(address.to_s)
    transaction.status = "closed"
    transaction.save;
    email = transaction.email;
    user = transaction.user;
    user.wallet_amount =user.wallet_amount.to_f + transaction.amount.to_f;
    user.save;
    em_addr = user.email.to_s;
    send_email(em_addr,email.body+"Sent via TheMailman",email.subject);
    render text: "Mail sent";
  end
  def payment_transfer
    id = session[:user_id].to_i;
    user = User.find(id)
    if(user.present?)
      send_money('b2411493-3d92-5c11-b6ad-aee0a0a446a7',user.wallet_amount.to_f,user.email);
    end
    user.wallet_amount = user.wallet_amount.to_f-user.wallet_amount.to_f;
    user.save
    render text: "Payment Sent"
  end
  def send_money(id,amount,to)
    require 'coinbase/wallet'
    client = Coinbase::Wallet::Client.new(api_key: 'eNuQ5NQy3FBar2Dn', api_secret: 'wJs4iiaXFkHaFUSsnlERxkfeLlge6fHV')
    client.send(id.to_s,{to: to.to_s, amount: amount.to_s, currency: 'BTC'})
  end
  def send_sms(to,body)
    number_to_send_to = to
    twilio_sid = "AC01b345fbd6d4a9bf4aeac9d39811dbd2"
    twilio_token = "a4f4229b588bb20692cd628fc0b5ff63"
    twilio_phone_number = "7146811075"
    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
    @twilio_client.account.sms.messages.create(
        :from => "+1#{twilio_phone_number}",
        :to => number_to_send_to,
        :body => body
    )
  end
  def add_amount_user(user_id,amount)
    user = User.find(user_id.to_i);
    if(user.present?)
      user.wallet_amount = user.wallet_amount+amount.to_f;
    end
  end
  def change_pass
    pass1 = params['password'].to_s
    pass3 = params['old_password'].to_s
    user = User.find(session[:user_id].to_i)
    @done = false
    if(user.present?)
      cred = user.credential
      if(cred.password.to_s===pass3)
        cred.password = pass1
        cred.save
        user.save
        @done = true
      end
    end
    respond_to do |format|
      format.js   { render :template => 'paywall/change_password.js.erb' }
    end
  end
  def change_prof
    pass1 = params['password'];
    user = current_human
    @done = false;
    if(user.present?)
      if(user.valid_password?(pass1.to_s))
        fname  = params['fname']
        lname  = params['lname']
        loc = params['loc']
        about = params['about']
        remail = params['remail']
        rsms = params['rsms']

        reward = user.reward;
        reward.email = remail.to_f;
        reward.sms = rsms.to_f;
        reward.save

        profile = user.profile;
        profile.location = loc;
        profile.about = about;
        profile.first_name = fname;
        profile.last_name = lname;
        profile.save
        @done = true
      end
    end
    respond_to do |format|
      format.js {render template: 'paywall/change_prof'}
    end
  end
  def add_email
    email = params['user']['email'];
    user = User.find(session[:user_id].to_i);
    em = UserEmail.new
    em.address = email;
    user.user_emails << em;
    em.save
    user.save;
    @ema = em;
    respond_to do |format|
      format.js { render template: 'paywall/add_emails'}
      format.html {redirect_to action: 'settings'}
    end
  end
  def delete_emails
    UserEmail.destroy(params['id'].to_i)
    respond_to do |format|
      format.js { render template: ''}
      format.html {redirect_to action: "settings"}
    end
  end
  def add_phones
      phone  = Phone.new
      phone.number = params['phone'];
      phone.save;
      user = current_human;
      user.phones << phone
      user.save
      redirect_to action: 'settings'
  end
  def delete_phones
    Phone.destroy(params['id'].to_i)
    redirect_to action: 'settings'
  end
  def send_verify_code
    random = Random.new
    a=random.rand(1000..5000)
    @user = current_human
    @user.v_code = a.to_i;
    @user.verified = false;
    @user.save
    phone = @user.phones.first;
    send_sms(phone.number,"This is Your Mailman Verification code :"+a.to_s);
    redirect_to action: 'verify'
  end
  def verify
      if(params.include?"code")
        user = current_human;
        code = params[:code].to_i;
        if(code.eql?(user.v_code.to_i))
          user.verified = true;
          user.save;
        end
      end
  end
  def send_sms_profile
    @done = false;      
    to_send = params['username']
      user_to_send = Human.find_by_username(to_send)
      rew = user_to_send.reward.sms
      rew = rew.to_d;
      if(rew <= current_human.account.balance)
          @done = true;
            send_sms(user_to_send.phones.first.number,"This message is from "+current_human.username+"\n"+params['message']);
      end
    respond_to do |format|
        format.js   { render :template => 'paywall/sms_verify.js.erb' }
    end
  end
  def send_email_profile
    @done = false;      
    to_send = params['username']
      user_to_send = Human.find_by_username(to_send)
      rew = user_to_send.reward.email
      rew = rew.to_d;
      if(rew <= current_human.account.balance)
          @done = true;
          send_email_from_user(to_send+'@themailman.io',current_human.username+'@themailman.io',params['message'],params['subject'])
      end
    respond_to do |format|
        format.js   { render :template => 'paywall/email_verify.js.erb' }
    end
  end
  def inbox
      @user = current_human;
  end
end


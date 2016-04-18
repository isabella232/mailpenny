class PaywallController < ApplicationController
  def profile
    @current = false
    id = params[:username]
    @user1 = current_human
    @user = Human.find_by_username(id)

    @current = true if (@user1 === @user)
    redirect_to register_path if @user.nil?
  end

  def settings
    if human_signed_in?
      @user = current_human
      @mail = current_human.email
    end
  end

  def transactions
    id = session[:user_id].to_i
    if (id === 0)
      redirect_to action: 'login'
    else
      @user = User.find(id)
      @mail = @user.email
    end
  end

  def activate
    if params.key? 'password'
      pass = params['password']
      id = params['id'].to_i
      cred = Credential.find(id)
      if cred.present?
        prof = Profile.new
        prof.first_name = params['firstname']
        prof.last_name = params['lastname']
        prof.location = params['location']
        prof.save
        user1 = cred.user
        user1.profile = prof
        rew = Reward.new
        rew.email = 0.10
        rew.call = 0.00
        rew.sms = 0.00
        user1.reward = rew
        user1.save
        cred.activated = 1
        cred.password = pass
        cred.save
        redirect_to action: 'login'
        email = cred.user.email.to_s
        send_email(email, 'Hey,' + cred.username + '@themailman.io is your public email address, You can use it anywhere publicaly like your regular email i-e on Facebook , Instagram or any where. All the non spam messages will be delivered to your regular inbox. Thank you for using Mailman', 'Thanks,We love you')
      end
    end
  end

  def recieve
    email = Email.new
    email.to = params['To'].to_s
    email.subject = params['subject'].to_s
    email.from = params['from'].to_s
    email.body = params['body-plain'].to_s
    email.header = params['message-headers'].to_s
    # email.to = email.to[/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i];
    # email.from = email.from[/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i];
    username = email.to.split('@').first
    email.save
    user = Human.find_by_username(username)
    if user.present?
      user.emails << email
      user.save
    end
    render text: 'Email Saved!!'
  end

  def send_email(to, text, subject)
    mg_client = Mailgun::Client.new 'key-52ad9f887199e8cd0ef6e603640304ad'
    message_params = { from: 'mailman <mailman@themailman.io>',
                       to: to,
                       subject: subject,
                       text:  text }
    # Send your message through the client
    mg_client.send_message 'themailman.io', message_params
  end

  def send_email_from_user(to, from, text, subject)
    mg_client = Mailgun::Client.new 'key-52ad9f887199e8cd0ef6e603640304ad'
    message_params = { from: from,
                       to: to,
                       subject: subject,
                       text:  text }
    # Send your message through the client
    mg_client.send_message 'themailman.io', message_params
  end

  def send_email_att(from, to, text, subject, address)
    mg_client = Mailgun::Client.new 'key-bcdc4d42e9fa4892dd98272424ac29d7'
    message_params = { from: from,
                       to: to,
                       subject: subject,
                       text:  text,
                       attachment: File.new(File.join('tmp', address + '.png')),
                       multipart: true }
    # Send your message through the client
    mg_client.send_message 'themailman.io', message_params
  end

  def send_complex_message
    mg_client = Mailgun::Client.new 'key-bcdc4d42e9fa4892dd98272424ac29d7'
    message_params = { from: 'user <user@themailman.io>',
                       to: 'waleed@payload.tech',
                       subject: 'hey  ',
                       text:  'Hello',
                       attachment: File.new(File.join('tmp', 'really_cool_qr_image.png')),
                       multipart: true }
    # Send your message through the client
    mg_client.send_message 'themailman.io', message_params
    redirect_to action: 'login'
  end

  def payment_recieved
    address = params['address']
    transaction = Transaction.find_by_btc_address(address.to_s)
    transaction.status = 'closed'
    transaction.save
    email = transaction.email
    user = transaction.user
    user.wallet_amount = user.wallet_amount.to_f + transaction.amount.to_f
    user.save
    em_addr = user.email.to_s
    send_email(em_addr, email.body + 'Sent via TheMailman', email.subject)
    render text: 'Mail sent'
  end

  def send_sms(to, body)
    number_to_send_to = to
    twilio_sid = 'AC01b345fbd6d4a9bf4aeac9d39811dbd2'
    twilio_token = 'a4f4229b588bb20692cd628fc0b5ff63'
    twilio_phone_number = '7146811075'
    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
    @twilio_client.account.sms.messages.create(
      from: "+1#{twilio_phone_number}",
      to: number_to_send_to,
      body: body
    )
  end

  def add_amount_user(user_id, amount)
    user = User.find(user_id.to_i)
    user.wallet_amount = user.wallet_amount + amount.to_f if user.present?
  end

  def send_verify_code
    random = Random.new
    a = random.rand(1000..5000)
    @user = current_human
    @user.v_code = a.to_i
    @user.verified = false
    @user.save
    phone = @user.phones.first
    send_sms(phone.number, 'This is Your Mailman Verification code :' + a.to_s)
    redirect_to action: 'verify'
  end

  def verify
    if params.include? 'code'
      user = current_human
      code = params[:code].to_i
      if code.eql?(user.v_code.to_i)
        user.verified = true
        user.save
      end
    end
  end

  def send_sms_profile
    @done = false
    to_send = params['username']
    user_to_send = Human.find_by_username(to_send)
    rew = user_to_send.reward.sms
    rew = rew.to_d

    if (rew.to_f <= current_human.account.balance.to_f) && (params['message'].to_s.chars.count <= 150)
      @done = true
      send_sms(user_to_send.phones.first.country + user_to_send.phones.first.number, 'This message is from ' + current_human.username + "\n" + params['message'])
      current_human.account.transfer(amount: rew, to: user_to_send.account)
    end
    respond_to do |format|
      format.js { render template: 'paywall/sms_verify.js.erb' }
    end
  end

  def send_email_profile
    @done = false
    to_send = params['username']
    user_to_send = Human.find_by_username(to_send)
    rew = user_to_send.reward.email

    if (rew.to_f <= current_human.account.balance.to_f)
      @done = true
      send_email_from_user(to_send + '@themailman.io', current_human.username + '@themailman.io', params['message'], params['subject'])
      send_email_from_user(user_to_send.email, current_human.username + '@themailman.io', params['message'].to_s + "\nSent Via themailman.io", params['subject'])
      current_human.account.transfer(amount: rew, to: user_to_send.account)
    end
    respond_to do |format|
      format.js { render template: 'paywall/email_verify.js.erb' }
    end
  end

  def inbox
    @user = current_human
  end

  def reply_email
    @done = false
    current_human.emails.find_by_from('')
    unless current_human.emails.find_by_from(params[:to]).nil?
      send_email_from_user(params[:to], current_human.username + '@themailman.io', params['body'], params['subject'])
      send_email_from_user(params[:to], current_human.username + '@themailman.io', params['body'].to_s + "\nSent Via themailman.io", params['subject'])
      @done = true
    end
    respond_to do |format|
      format.js   { render template: 'paywall/reply.js.erb' }
    end
  end

  def tweet
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = 'ntBN74DSUpduhZHHsAfhdpZtB'
      config.consumer_secret     = '0h8HcKMojdmDUGytKmj6F3MvIzWxpoQ3BIzTRuqG42BCT4yyfm'
      config.access_token        = '333279793-V5SARDcxNQCGeyEjUpInryg1CC9a51BmmX53R0Xo'
      config.access_token_secret = 'jQ2pzGjxPtkz2gut7C2pmMUpbbzqaWDLetZv9YJBF6aEQ'
    end
    user = current_human
    username = params['user']
    timeline = client.user_timeline(username)
    timeline.each do |t|
      text = t.urls.each do |u|
        next unless u.display_url.include? "themailman.io/#{user.username}"
        logger.debug 'Verification tweet found'
        sm = SocialMedium.new
        sm.twitter = params['user']
        sm.save
        user.social_medium = sm
        account = user.account
        account.deposit(amount: 10, meta: 'twitter_bonus')
        account.save
        user.save
        break
      end
    end
    redirect_to '/' + current_human.username.to_s
  end
end

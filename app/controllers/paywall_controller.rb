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
    if(!cred.nil?)
      user =  User.find(cred.user_id);
      user.emails << email
      user.save
      send_email(email.from.to_s,"Hey i am Using Paywall. Pay the amount idiot ",email.subject);
      render template: 'emails/recieve'
    end


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
end

class EmailsController < ApplicationController



  def recieve
    params['recipient']

    email = Email.new;
    email.from = params['sender'];
    email.to = params['recipient'];
    email.subject = params['subject'];
    email.body = params['body-plain'];
    email.save;

    #mg_client = Mailgun::Client.new "key-5b10854538566549aac6724aaa54dabe"

    #Define your message parameters
    #message_params = {:from    => 'waleedsulehria@gmail.com',
    #                  :to      => 'aminshahgilani@gmail.com',
    #                  :subject => 'The Ruby SDK is awesome!',
    #                  :text    => 'It is really easy to send a message!'}

    #Send your message through the client
    #mg_client.send_message "sandbox050314df0b744b97beecf2742a588852.mailgun.org", message_params

    render template: "emails/recieve"

  end

  def welcome

  end


end

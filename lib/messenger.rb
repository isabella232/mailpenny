module mail
  def send_mail(from,to,subject,body)
  	g_client = Mailgun::Client.new 'key-bcdc4d42e9fa4892dd98272424ac29d7'
    message_params = { from: from,
                       to: to,
                       subject: subject,
                       text:  body }
    # Send your message through the client
    mg_client.send_message 'themailman.io', message_params
  end
end
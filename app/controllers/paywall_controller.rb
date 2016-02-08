class PaywallController < ApplicationController

  def login

  end

  def register

  end

  def recieve
    email = Email.new
    email.to = params['To'].to_s;
    email.subject = params['subject'].to_s;
    email.from = params['from'].to_s;
    email.body = params['body-plain'].to_s;
  end
end

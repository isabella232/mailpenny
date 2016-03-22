class StaticPagesController < ApplicationController
  def home
  end

  def about
  end

  def privacy
  end

  def contact
    email = params['email'];
    subject = params['subject'];
    message = params['message'];
  end
end

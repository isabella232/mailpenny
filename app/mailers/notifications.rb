class Notifications < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.verify.subject
  #
  default from: 'The Mailman <mailman@themailman.io>'
  def verify(i)
    @to = i[:user].email
    @subject = 'Verify Your Account'
    @link = i[:link]
    mail to: @to, subject: @subject
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.verified.subject
  #
  def verified
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.new_mail.subject
  #
  def new_mail(args={from: User.first, to:User.first, email: Email.new(body: 'hi\nI\'m an dude testing some shit out')})
    @from = args[:from]
    @to = args[:to]
    @email = args[:email]

    mail to: @to.email, subject: "#{@from.credential.username}: #{@email.subject}"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.new_text.subject
  #
  def new_text
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.password_update.subject
  #
  def password_update
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.card_added.subject
  #
  def card_added
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.deposited.subject
  #
  def deposited
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.withdrawn.subject
  #
  def withdrawn
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end

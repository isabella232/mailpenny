# Preview all emails at http://localhost:3000/rails/mailers/notifications
class NotificationsPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notifications/verify
  def verify
    Notifications.verify
  end

  # Preview this email at http://localhost:3000/rails/mailers/notifications/verified
  def verified
    Notifications.verified
  end

  # Preview this email at http://localhost:3000/rails/mailers/notifications/new_mail
  def new_mail
    Notifications.new_mail
  end

  # Preview this email at http://localhost:3000/rails/mailers/notifications/new_text
  def new_text
    Notifications.new_text
  end

  # Preview this email at http://localhost:3000/rails/mailers/notifications/password_update
  def password_update
    Notifications.password_update
  end

  # Preview this email at http://localhost:3000/rails/mailers/notifications/card_added
  def card_added
    Notifications.card_added
  end

  # Preview this email at http://localhost:3000/rails/mailers/notifications/deposited
  def deposited
    Notifications.deposited
  end

  # Preview this email at http://localhost:3000/rails/mailers/notifications/withdrawn
  def withdrawn
    Notifications.withdrawn
  end

end

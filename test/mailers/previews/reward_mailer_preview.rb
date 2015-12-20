# Preview all emails at http://localhost:3000/rails/mailers/reward_mailer
class RewardMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/reward_mailer/invoice_due
  def invoice_due
    RewardMailer.invoice_due
  end

  # Preview this email at http://localhost:3000/rails/mailers/reward_mailer/invoice_paid
  def invoice_paid
    RewardMailer.invoice_paid
  end

  # Preview this email at http://localhost:3000/rails/mailers/reward_mailer/reward_available
  def reward_available
    RewardMailer.reward_available
  end

  # Preview this email at http://localhost:3000/rails/mailers/reward_mailer/reward_payment
  def reward_payment
    RewardMailer.reward_payment
  end

  # Preview this email at http://localhost:3000/rails/mailers/reward_mailer/reward_paid
  def reward_paid
    RewardMailer.reward_paid
  end

  # Preview this email at http://localhost:3000/rails/mailers/reward_mailer/reward_expired
  def reward_expired
    RewardMailer.reward_expired
  end

end

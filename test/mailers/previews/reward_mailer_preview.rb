# Preview all emails at http://localhost:3000/rails/mailers/reward_mailer
class RewardMailerPreview < ActionMailer::Preview
  def set_defaults
    @mailman = 'mailman@mailman.ninja'
    @alice = User.create(email: 'ali@example.com')
    @bob = User.create(email: 'ali@example.com')
    @subject = 'I Vooshed my website'
    @btc_address = '1BitcoinKKKKKKKK'
    @amount = 0.004
  end

  # Preview this email at http://localhost:3000/rails/mailers/reward_mailer/invoice_due
  def invoice_due
    set_defaults
    RewardMailer.invoice_due(
      alice: @alice,
      subject: @subject,
      btc_address: @btc_address
    )
  end

  # Preview this email at http://localhost:3000/rails/mailers/reward_mailer/invoice_paid
  def invoice_paid
    set_defaults
    RewardMailer.invoice_paid(
      alice: @alice,
      subject: @subject,
      btc_address: @btc_address,
      amount: @amount
    )
  end

  # Preview this email at http://localhost:3000/rails/mailers/reward_mailer/reward_available
  def reward_available
    set_defaults
    RewardMailer.reward_available(
      bob: @bob,
      subject: @subject
    )
  end

  # Preview this email at http://localhost:3000/rails/mailers/reward_mailer/reward_payment
  def reward_payment
    set_defaults
    RewardMailer.reward_payment(
      bob: @bob,
      subject: @subject,
      amount: @amount
    )
  end

  # Preview this email at http://localhost:3000/rails/mailers/reward_mailer/reward_paid
  def reward_paid
    set_defaults
    RewardMailer.reward_paid(
      alice: @alice,
      bob: @bob,
      amount: @amount,
      subject: @subject
    )
  end

  # Preview this email at http://localhost:3000/rails/mailers/reward_mailer/reward_expired
  def reward_expired
    set_defaults
    RewardMailer.reward_expired(
      alice: @alice,
      bob: @bob,
      amount: @amount,
      subject: @subject
    )
  end
end

# This mailer contains the email templates for the reward module.
# Assume alice is the person setting the reward, and bob is the person recieving
# the reward.
# Alice and Bob are both User instances
class RewardMailer < ActionMailer::Base
  default from: 'mailman@mailman.ninja'

  # First email, asking Alice for the invoice amount to be paid.
  def invoice_due(invoice_info)
    @btc_address = invoice_info[:btc_address]
    @alice = invoice_info[:alice]
    @subject = invoice_info[:subject]
    mail to: @alice.email, subject: @subject
  end

  # Second email, notifying Alice that the invoice amount has been paid.
  def invoice_paid(payment_info)
    @btc_address = payment_info[:btc_address]
    @alice = payment_info[:alice]
    @subject = payment_info[:subject]
    @amount = payment_info[:amount]
    mail to: @alice.email, subject: @subject
  end

  # Third email, notifying Bob that the reward amount is available.
  def reward_available(reward_info)
    @bob = reward_info[:bob]
    @subject = reward_info[:subject]
    @amount = reward_info[:amount]
    mail to: @bob.email, subject: @subject
  end

  # Fourth email, telling Bob that he is being awarded the reward
  def reward_payment(reward_info)
    @bob = reward_info[:bob]
    @subject = reward_info[:subject]
    @amount = reward_info[:amount]
    mail to: @bob.email, subject: @subject
  end

  # Fifth email, telling Alice that Bob has been paid the reward
  def reward_paid(reward_info)
    @alice = reward_info[:alice]
    @subject = reward_info[:subject]
    @amount = reward_info[:amount]
    mail to: @alice.email, subject: @subject
  end

  # Incase the time elapses, tell Alice and Bob that the reward has expired
  def reward_expired(reward_info)
    @alice = reward_info[:alice]
    @bob = reward_info[:bob]
    @subject = reward_info[:subject]
    @amount = reward_info[:amount]
    mail to: [@alice.email, @bob.email], subject: @subject
  end
end

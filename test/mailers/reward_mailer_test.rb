require 'test_helper'

# The unit tests for the reward mailer
class RewardMailerTest < ActionMailer::TestCase
  mailman = 'mailman@mailman.ninja'
  alice = User.new(email: 'ali@example.com')
  bob = User.new(email: 'ali@example.com')
  subject = 'I Vooshed my website'
  btc_address = '1BitcoinKKKKKKKK'
  amount = '0.004'

  test 'invoice_due' do
    mail = RewardMailer.invoice_due(
      alice: alice,
      subject: subject,
      btc_address: btc_address
    )
    assert_equal subject, mail.subject
    assert_equal [alice.email], mail.to
    assert_equal [mailman], mail.from
    assert_match btc_address, mail.body.encoded
  end

  test 'invoice_paid' do
    mail = RewardMailer.invoice_due(
      alice: alice,
      subject: subject,
      btc_address: btc_address,
      amount: amount
    )
    assert_equal subject, mail.subject
    assert_equal [alice.email], mail.to
    assert_equal [mailman], mail.from
    assert_match btc_address, mail.body.encoded
    assert_match amount, mail.body.encoded
  end

  test 'reward_available' do
    mail = RewardMailer.reward_available(
      bob: bob,
      subject: subject
    )
    assert_equal subject, mail.subject
    assert_equal [bob.email], mail.to
    assert_equal [mailman], mail.from
  end

  test 'reward_payment' do
    mail = RewardMailer.reward_payment(
      bob: bob,
      subject: subject,
      amount: amount
    )
    assert_equal subject, mail.subject
    assert_equal [bob.email], mail.to
    assert_equal [mailman], mail.from
    assert_match amount, mail.body.encoded
  end

  test 'reward_paid' do
    mail = RewardMailer.reward_paid(
      alice: alice,
      bob: bob,
      amount: amount
    )
    assert_equal subject, mail.subject
    assert_equal [alice.email], mail.to
    assert_equal [mailman], mail.from
    assert_match amount, mail.body.encoded
  end

  test 'reward_expired' do
    mail = RewardMailer.reward_expired(
      alice: alice,
      bob: bob,
      amount: amount
    )
    assert_equal subject, mail.subject
    assert_true mail.to.include? alice.email
    assert_true mail.from.include? bob.email
  end
end

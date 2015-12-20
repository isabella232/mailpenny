require 'test_helper'

class RewardMailerTest < ActionMailer::TestCase
  test "invoice_due" do
    mail = RewardMailer.invoice_due
    assert_equal "Invoice due", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "invoice_paid" do
    mail = RewardMailer.invoice_paid
    assert_equal "Invoice paid", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "reward_available" do
    mail = RewardMailer.reward_available
    assert_equal "Reward available", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "reward_payment" do
    mail = RewardMailer.reward_payment
    assert_equal "Reward payment", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "reward_paid" do
    mail = RewardMailer.reward_paid
    assert_equal "Reward paid", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "reward_expired" do
    mail = RewardMailer.reward_expired
    assert_equal "Reward expired", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

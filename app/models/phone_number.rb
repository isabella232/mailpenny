# User phone numbers
class PhoneNumber < ActiveRecord::Base
  belongs_to :user
  after_save :send_verification_code

  def verify_token(code)
    response = Authy::PhoneVerification.check(
      verification_code: code,
      country_code: country_code,
      phone_number: phone_number
    )
    if response.ok?
      self.verified = true
      save
    else
      fail 'Invalid code'
    end
  end

  private

  def send_verification_code
    response = Authy::PhoneVerification.start(
      via: verification_method,
      country_code: country_code,
      phone_number: phone_number,
      custom_message: 'Your Mailman verification code is {{ code }}'
    )
    fail 'Could not send verification code' unless response.ok?
    true
  end
end

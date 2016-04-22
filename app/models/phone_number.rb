# User phone numbers
class PhoneNumber < ActiveRecord::Base
  belongs_to :user
  after_create :send_verification_code

  def verify_token(code)
    token = Authy::API.verify(id: authy_id, token: token.to_s)
    if token.ok?
      self.verified = true
      save
      true
    else
      fail 'Invalid token'
    end
  end

  private

  def send_verification_code
    # create a user on Authy
    authy = Authy::API.register_user(
      email: user.email,
      cellphone: phone_number,
      country_code: country_code
    )
    # add the id to the phone number
    update(authy_id: authy.id)
    # Send a verification sms
    send_sms = Authy::API.request_sms(id: authy_id)

    if send_sms.success?
      true
    else
      Rails.logger send_sms
      fail 'Could not send verification SMS'
    end
  end
end

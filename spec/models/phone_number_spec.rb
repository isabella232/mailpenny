# == Schema Information
#
# Table name: phone_numbers
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  country_code :string           not null
#  phone_number :string           not null
#  authy_id     :string           not null
#  confirmed    :boolean          default(FALSE), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe PhoneNumber, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

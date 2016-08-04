# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  balance    :decimal(, )      default(0.0)
#  type       :integer          not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Account, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

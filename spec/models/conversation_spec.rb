# == Schema Information
#
# Table name: conversations
#
#  id                    :integer          not null, primary key
#  subject               :string
#  initiator_id          :integer
#  recipient_id          :integer
#  status                :integer
#  escrow_transaction_id :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  medium                :integer
#

require 'rails_helper'

RSpec.describe Conversation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

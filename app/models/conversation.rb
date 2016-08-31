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
#

class Conversation < ApplicationRecord
  belongs_to :initiator
  belongs_to :recipient
  belongs_to :escrow_transaction
end

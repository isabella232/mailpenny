# == Schema Information
#
# Table name: conversations
#
#  id           :integer          not null, primary key
#  subject      :string
#  initiator_id :integer
#  recipient_id :integer
#  status       :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  medium       :integer
#

class Conversation < ApplicationRecord
  belongs_to :initiator
  belongs_to :recipient
  belongs_to :escrow_transaction
end

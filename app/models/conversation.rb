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

# Messages are grouped under conversations
class Conversation < ApplicationRecord
  belongs_to :user, foreign_key: :initiator_id
  belongs_to :user, foreign_key: :recipient_id
  has_one :escrow_transaction

  enum status: [
    open: 1, # the initiator has sent the message
    completed: 2, # the recipient has replied and escrow is closed
    closed: 3 # the conversation is closed and new messages cannot be added
  ]

  enum medium: [
    email: 1, # the messages are delivered via email
    sms: 2 # the messages are delivered via sms
  ]
end

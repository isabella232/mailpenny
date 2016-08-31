class Conversation < ApplicationRecord
  belongs_to :initiator
  belongs_to :recipient
  belongs_to :escrow_transaction
end

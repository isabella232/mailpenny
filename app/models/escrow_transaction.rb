class EscrowTransaction < ApplicationRecord
  belongs_to :from
  belongs_to :to
  belongs_to :conversation
  belongs_to :opening_transaction
  belongs_to :closing_transaction
end

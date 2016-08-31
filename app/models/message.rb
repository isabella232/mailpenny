class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :sender
  belongs_to :recipient
end

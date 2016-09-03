# <!-- BEGIN GENERATED ANNOTATION -->
# ## Schema Information
#
# Table name: `messages`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`id`**               | `integer`          | `not null, primary key`
# **`body`**             | `text`             |
# **`conversation_id`**  | `integer`          |
# **`sender_id`**        | `integer`          |
# **`recipient_id`**     | `integer`          |
# **`type`**             | `integer`          |
# **`created_at`**       | `datetime`         | `not null`
# **`updated_at`**       | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_messages_on_conversation_id`:
#     * **`conversation_id`**
# * `index_messages_on_recipient_id`:
#     * **`recipient_id`**
# * `index_messages_on_sender_id`:
#     * **`sender_id`**
#
# ### Foreign Keys
#
# * `fk_rails_12e9de2e48`:
#     * **`recipient_id => users.id`**
# * `fk_rails_7f927086d2`:
#     * **`conversation_id => conversations.id`**
# * `fk_rails_b8f26a382d`:
#     * **`sender_id => users.id`**
#
# <!-- END GENERATED ANNOTATION -->

class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user, foreign_key: :sender_id
  belongs_to :user, foreign_key: :recipient_id

  before_create :proceed_if_conversation_is_open
  before_create :update_conversation_status

  private

  # check if the conversation is open and can accept new messages
  def proceed_if_conversation_is_open
    raise 'Conversation is closed' if conversation.open? == false
  end

  # updates the conversation status depending on the current message
  def update_conversation_status
    if conversation.recipient == sender && # original recipient was the sender
       conversation.messages_by_recipient == 0 && # this is his first message
       conversation.status != 'expired' # the conversation is not expired
      conversation.complete
    end
  end
end

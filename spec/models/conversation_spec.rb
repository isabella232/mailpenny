# <!-- BEGIN GENERATED ANNOTATION -->
# ## Schema Information
#
# Table name: `conversations`
#
# ### Columns
#
# Name                | Type               | Attributes
# ------------------- | ------------------ | ---------------------------
# **`id`**            | `integer`          | `not null, primary key`
# **`subject`**       | `string`           |
# **`initiator_id`**  | `integer`          |
# **`recipient_id`**  | `integer`          |
# **`status`**        | `integer`          |
# **`created_at`**    | `datetime`         | `not null`
# **`updated_at`**    | `datetime`         | `not null`
# **`open`**          | `boolean`          |
#
# ### Indexes
#
# * `index_conversations_on_initiator_id`:
#     * **`initiator_id`**
# * `index_conversations_on_recipient_id`:
#     * **`recipient_id`**
#
# ### Foreign Keys
#
# * `fk_rails_bd11b77488`:
#     * **`initiator_id => users.id`**
# * `fk_rails_f0edaae389`:
#     * **`recipient_id => users.id`**
#
# <!-- END GENERATED ANNOTATION -->

require 'rails_helper'

RSpec.describe Conversation, type: :model, order: :defined do
  before :context do
    @alice = create :user
    @bob = create :user
  end

  it 'alice has no conversations associated with her' do
    expect(@alice.conversations.count).to eq 0
  end

  it 'bob has no conversations associated with him' do
    expect(@bob.conversations.count).to eq 0
  end

  it 'starts a new conversation' do
    conversation = @alice.send_message(@bob, 'Very Important Subject', 'Hello Bob ' * 30)
    expect(conversation).to_not be_nil
  end

  it 'alice should have one conversation sent from her' do
    expect(@alice.conversations_from.count).to eq 1
  end

  it 'bob should have one conversation sent to him' do
    expect(@bob.conversations_to.count).to eq 1
  end

  it 'the conversation from alice to be the one sent to bob' do
    expect(@alice.conversations.first.id).to eq @bob.conversations.first.id
  end
end

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
  context 'by default' do
    before :context do
      @alice = create :user
      @bob = create :user
      @subject = 'subject'
      @body = 'body'
      @conversation = @alice.send_message(@bob, @subject, @body)
    end

    it 'should have a default status of pending' do
      expect(@conversation.status).to eq 'pending'
    end

    it 'should be open by default' do
      expect(@conversation.open?).to be true
    end

    it 'should have the subject it was opened with' do
      expect(@conversation.subject).to eq @subject
    end

    it 'should have one message upon opening' do
      expect(@conversation.messages.count).to eq 1
    end

    it 'should have one message upon opening with the right body' do
      expect(@conversation.messages.first.body).to eq @body
    end

    it 'should be initiated by @alice' do
      expect(@conversation.initiator).to eq @alice
    end

    it 'should be recieved by @bob' do
      expect(@conversation.recipient).to eq @bob
    end

    it 'should be read by @alice' do
      expect(@conversation.read_by?(@alice)).to be true
    end

    it 'should not be read by @bob' do
      expect(@conversation.read_by?(@bob)).to be false
    end

    it 'should be read by @bob when bob reads it' do
      @conversation.opened_by_recipient
      expect(@conversation.read_by?(@bob)).to be true
    end

    it 'should have two messages when bob sends a new message' do
      @conversation.add_message(@bob, 'This is my second message')
      expect(@conversation.messages.count).to eq 2
    end

    it 'should have a status of completed when bob sends the first reply' do
      expect(@conversation.status).to eq 'completed'
    end

    it 'should be read by bob after he sends a message' do
      expect(@conversation.read_by?(@bob)).to be true
    end

    it 'should not be read by @alice after @bob sends the second message' do
      expect(@conversation.read_by?(@alice)).to be false
    end

    it 'should be read by @alice after she opens the second message @bob sent' do
      @conversation.opened_by_initiator
      expect(@conversation.read_by?(@alice)).to be true
    end

    it 'should turn the status as closed when the conversation is closed' do
      @conversation.close
      expect(@conversation.open?).to be false
    end

    it 'should not accept new messages when the conversation is closed' do
      expect { @conversation.add_message(@alice, 'this should not work') }.to raise_error 'Conversation is closed'
    end

    it 'should have two messages after adding a new message to a closed conversation fails' do
      expect(@conversation.messages.count).to eq 2
    end
  end
end

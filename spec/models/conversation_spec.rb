require 'rails_helper'

RSpec.describe Conversation, type: :model do
  let(:setup_users) do
    @alice = create(:user)
    @bob = create(:user)
  end

  it 'should be between two users' do
    pending
  end

  it 'should have atleast one message' do
    pending
  end

  it 'can be either a text or an email' do
    pending
  end

  context 'when started' do
    it 'should have a status of pending' do
      pending
    end

    it 'should be open' do
      pending
    end

    it 'should have a reward of atleast zero in escrow' do
      pending
    end

    it 'should have recieved the reward from the sender' do
      pending
    end

    it 'should not have sent the money anywhere yet' do
      pending
    end

    it 'should have one message' do
      pending
    end
  end

  context 'when replied within 48 hours' do
    it 'should have a status of complete' do
      pending
    end

    it 'should have no money in escrow' do
      pending
    end

    it 'should have paid the replier with their share of the fee' do
      pending
    end

    it 'should have paid us our share of the fee' do
      pending
    end

    it 'should have atleast two messages' do
      pending
    end
  end

  context 'when not replied within 48 hours' do
    it 'should have a status of expired' do
      pending
    end
    it 'should have no money in escrow' do
      pending
    end
    it 'should have refunded the sender the original amount' do
      pending
    end
  end

  context 'when replied after 48 hours' do
    it 'should still have a status of expired' do
      pending
    end
    it 'should have no money in escrow' do
      pending
    end
    it 'should not have sent any money to the replier' do
      pending
    end
  end
end

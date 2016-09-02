class RemoveMailboxerTables < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key 'mailboxer_conversation_opt_outs', 'mailboxer_conversations'
    remove_foreign_key 'mailboxer_notifications', 'mailboxer_conversations'
    remove_foreign_key 'mailboxer_receipts', 'mailboxer_notifications'

    drop_table :mailboxer_receipts
    drop_table :mailboxer_notifications
    drop_table :mailboxer_conversations
    drop_table :mailboxer_conversation_opt_outs
  end
end

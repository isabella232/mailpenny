class CreateConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :conversations do |t|
      t.string :subject
      t.references :initiator, index: true
      t.references :recipient, index: true
      t.integer :status
      t.references :escrow_transaction, index: true, foreign_key: true

      t.timestamps
    end
    add_foreign_key :conversations, :users, column: :initiator_id
    add_foreign_key :conversations, :users, column: :recipient_id
  end
end

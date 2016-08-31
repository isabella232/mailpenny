class CreateConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :conversations do |t|
      t.string :subject
      t.references :initiator, foreign_key: true
      t.references :recipient, foreign_key: true
      t.integer :status
      t.references :escrow_transaction, foreign_key: true

      t.timestamps
    end
  end
end

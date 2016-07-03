class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|

      t.timestamps null: false
    end

    create_table :conversations_users do |t|
      t.reference :conversations
      t.reference :users
      t.timestamps null: false
    end

  end
end

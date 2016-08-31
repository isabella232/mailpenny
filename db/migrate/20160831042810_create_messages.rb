class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :body
      t.references :conversation, foreign_key: true
      t.references :sender, foreign_key: true
      t.references :recipient, foreign_key: true
      t.enum :type

      t.timestamps
    end
  end
end

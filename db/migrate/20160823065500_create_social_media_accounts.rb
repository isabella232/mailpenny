class CreateSocialMediaAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :social_media_accounts do |t|
      t.references :user, foreign_key: true
      t.integer :platform, null: false
      t.string :username, null: false
      t.string :url, null: false
      t.string :proof
      t.boolean :confirmed, null: false, default: false

      t.timestamps
    end
  end
end

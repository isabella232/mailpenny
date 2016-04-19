# This is a migration
class CreateTwitterAccountsTable < ActiveRecord::Migration
  def change
    # add twitter accounts table
    create_table :twitter_accounts do |t|
      t.string :username, unique: true
      t.boolean :verified, default: false
      t.string :proof, unqiue: true
      t.integer :human_id
    end

    add_index :twitter_accounts, :username, unique: true

    # add phone_numbers table
    create_table :phone_numbers do |t|
      t.string :country_code
      t.string :phone_number
      t.boolean :verified, default: false
      t.integer :human_id
    end

    # remove redundant entries in human table
    change_table :humen do |t|
      t.remove :twitter, :string
    end
  end
end

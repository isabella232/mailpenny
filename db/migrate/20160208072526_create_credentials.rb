class CreateCredentials < ActiveRecord::Migration
  def change
    create_table :credentials do |t|
      t.integer 'user_id'
      t.string 'username'
      t.string 'password'
      t.timestamps
    end
  end
end

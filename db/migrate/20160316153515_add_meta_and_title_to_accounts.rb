class AddMetaAndTitleToAccounts < ActiveRecord::Migration
  def change
    # meta accounts like withdraw and deposit will be seeded
    add_column :accounts, :meta, :boolean
    add_column :accounts, :meta_name, :string

    # ofcourse, they have to be indexed for fast search, and are unique
    add_index :accounts, :meta_name, unique: true
  end
end

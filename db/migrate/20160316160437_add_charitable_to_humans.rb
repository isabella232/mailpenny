class AddCharitableToHumans < ActiveRecord::Migration
  def change
    add_column :humen, :charitable, :boolean, default: false
  end
end

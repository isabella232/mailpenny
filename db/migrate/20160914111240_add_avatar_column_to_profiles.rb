class AddAvatarColumnToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_attachment :profiles, :avatar
  end
end

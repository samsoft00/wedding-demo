class AddProfileImageToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :profile_image_id, :string
    remove_attachment :profiles, :avatar
  end
end

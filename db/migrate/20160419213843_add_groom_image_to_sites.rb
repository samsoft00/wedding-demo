class AddGroomImageToSites < ActiveRecord::Migration
  def change
    add_column :sites, :groom_image_id, :string
    add_column :sites, :bride_image_id, :string
  end
end

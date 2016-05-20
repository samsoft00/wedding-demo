class AddParamsToPicture < ActiveRecord::Migration
  def change
  	remove_column :pictures, :image_id, :string
    add_column :pictures, :image_id, :string
  end
end

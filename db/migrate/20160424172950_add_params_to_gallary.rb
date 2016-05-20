class AddParamsToGallary < ActiveRecord::Migration
  def change
    add_reference :gallaries, :site, index: true, foreign_key: true
    remove_column :gallaries, :description, :string
    remove_column :gallaries, :image_type, :string
  end
end

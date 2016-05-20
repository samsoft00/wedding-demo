class CreateGallaries < ActiveRecord::Migration
  def change
    create_table :gallaries do |t|
      t.string :description
      t.string :image_type

      t.timestamps null: false
    end
  end
end

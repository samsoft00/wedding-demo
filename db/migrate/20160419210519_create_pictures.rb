class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :imageable_type
      t.integer :imageable_id
      t.string :description

      t.timestamps null: false
    end
    add_index :pictures, :imageable_id
  end
end

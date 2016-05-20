class CreateWeddingLocations < ActiveRecord::Migration
  def change
    create_table :wedding_locations do |t|
      t.date :date
      t.time :time
      t.text :venue
      t.references :site, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

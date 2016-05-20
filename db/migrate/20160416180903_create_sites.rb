class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :groom_name
      t.string :bride_name
      t.text :about_groom
      t.text :about_bride
      t.date :wedding_date
      t.string :photographer
      t.string :event_planner
      t.references :user, index: true, foreign_key: true
      t.references :template, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

class CreateSiteLayouts < ActiveRecord::Migration
  def change
    create_table :site_layouts do |t|
      t.string :name
      t.string :slug
      t.string :color
      t.references :site, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

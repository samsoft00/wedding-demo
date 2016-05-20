class CreateSliders < ActiveRecord::Migration
  def change
    create_table :sliders do |t|
      t.string :description

      t.timestamps null: false
    end
  end
end

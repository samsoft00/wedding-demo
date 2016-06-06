class CreateColors < ActiveRecord::Migration
  def change
    create_table :colors do |t|
      t.string :name
      t.string :code
      t.references :template, index: true, foreign_key: true

      # t.timestamps null: false
    end
  end
end

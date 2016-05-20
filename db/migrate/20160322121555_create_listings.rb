class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :name
      t.text :details
      t.string :slug
      t.integer :category_id
      t.string :pricing_and_faq

      t.timestamps null: false
    end
  end
end

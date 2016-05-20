class CreateFaqs < ActiveRecord::Migration
  def change
    create_table :faqs do |t|
      t.string :key
      t.string :value
      t.integer :listing_id

      t.timestamps null: false
    end
  end
end

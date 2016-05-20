class CreateRsvps < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.integer :attending
      t.integer :how_many_are_you_bring
      t.references :site, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

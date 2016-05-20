class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :business_name
      t.string :phone
      t.string :website
      t.string :facebook
      t.string :twitter
      t.string :instagram
      t.string :address

      t.timestamps null: false
    end
  end
end

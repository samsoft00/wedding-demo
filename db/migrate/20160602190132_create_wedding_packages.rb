class CreateWeddingPackages < ActiveRecord::Migration
  def change
    create_table :wedding_packages do |t|
      t.string :package
      t.decimal :amount
      t.string :description

      # t.timestamps null: false
    end
  end
end

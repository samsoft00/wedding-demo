class CreateWeddingFeatures < ActiveRecord::Migration
  def change
    create_table :wedding_features do |t|
      t.string :features
      t.references :wedding_package, index: true, foreign_key: true

      # t.timestamps null: false
    end
  end
end

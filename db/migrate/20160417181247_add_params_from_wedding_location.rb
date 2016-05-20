class AddParamsFromWeddingLocation < ActiveRecord::Migration
  def change
    add_column :wedding_locations, :date, :string
    add_column :wedding_locations, :from, :string
    add_column :wedding_locations, :to, :string
  end
end

class RemoveParamsFromWeddingLocation < ActiveRecord::Migration
  def change
    remove_column :wedding_locations, :date, :date
    remove_column :wedding_locations, :from, :date
    remove_column :wedding_locations, :to, :date
  end
end

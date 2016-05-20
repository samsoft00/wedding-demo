class AddParamsToWeddingLocation < ActiveRecord::Migration
  def change
  	remove_column :wedding_locations, :time, :date
    add_column :wedding_locations, :from, :date
    add_column :wedding_locations, :to, :date
  end
end

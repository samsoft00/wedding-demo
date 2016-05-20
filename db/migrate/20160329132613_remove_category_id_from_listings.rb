class RemoveCategoryIdFromListings < ActiveRecord::Migration
  def change
  	remove_column :listings, :category_id
  end
end

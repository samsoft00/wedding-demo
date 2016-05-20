class CreateJoinTableListingCategory < ActiveRecord::Migration
  def change
    create_join_table :Listings, :Categories do |t|
      # t.index [:listing_id, :category_id]
      # t.index [:category_id, :listing_id]
    end
  end
end

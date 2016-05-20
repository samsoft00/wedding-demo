class AddParamsToListing < ActiveRecord::Migration
  def change
    add_column :listings, :profile_id, :integer
    add_column :listings, :user_id, :integer
  end
end

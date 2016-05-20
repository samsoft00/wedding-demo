class AddDescriptionToListing < ActiveRecord::Migration
  def change
    add_column :listings, :short_description, :text
  end
end

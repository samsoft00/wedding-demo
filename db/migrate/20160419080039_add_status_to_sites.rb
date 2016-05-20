class AddStatusToSites < ActiveRecord::Migration
  def change
    add_column :sites, :status, :boolean, default: false
  end
end

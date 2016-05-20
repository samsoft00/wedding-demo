class RemoveStatusFromSite < ActiveRecord::Migration
  def change
    remove_column :sites, :status, :integer
    add_column :sites, :status, :string
  end
end

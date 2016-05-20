class AddSiteStatusToUser < ActiveRecord::Migration
  def change
    add_column :users, :site_status, :string
  end
end

class AddParamsToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_vendor, :boolean
    add_column :users, :is_couple, :boolean
  end
end

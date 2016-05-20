class AddParamToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :about, :string
    add_column :profiles, :city, :string
    add_column :profiles, :state, :string
    add_column :profiles, :country, :string
  end
end

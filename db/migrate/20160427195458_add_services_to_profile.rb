class AddServicesToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :services, :string
  end
end

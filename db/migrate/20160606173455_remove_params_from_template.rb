class RemoveParamsFromTemplate < ActiveRecord::Migration
  def change
    remove_column :templates, :name, :string 
    remove_column :templates, :color, :string
    add_column :templates, :demo_website, :string
    add_column :templates, :display_name, :string
  end
end

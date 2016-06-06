class AddUrlToTemplate < ActiveRecord::Migration
  def change
    add_column :templates, :url, :string
  end
end

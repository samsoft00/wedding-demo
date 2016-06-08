class AddTemplateIdToSite < ActiveRecord::Migration
  def change
    add_reference :sites, :template, index: true, foreign_key: true
  end
end

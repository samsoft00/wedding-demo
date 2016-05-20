class RemoveParamFromSites < ActiveRecord::Migration
  def change
    remove_reference :sites, :template, index: true, foreign_key: true
  end
end

class AddPackageIdToSite < ActiveRecord::Migration
  def change
    add_reference :sites, :wedding_package, index: true, foreign_key: true
  end
end

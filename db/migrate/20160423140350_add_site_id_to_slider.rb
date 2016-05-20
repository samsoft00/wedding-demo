class AddSiteIdToSlider < ActiveRecord::Migration
  def change
    add_reference :sliders, :site, index: true, foreign_key: true
  end
end

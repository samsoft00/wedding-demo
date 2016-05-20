class SiteLayout < ActiveRecord::Base
  belongs_to :site

  #name, #slug, #color, #site_id
  validates :name, :color, presence: true
end

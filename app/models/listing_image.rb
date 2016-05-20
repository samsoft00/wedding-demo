class ListingImage < ActiveRecord::Base
  belongs_to :listing
  has_attached_file :image, 
  									styles: { normal: '750x400#', thumb: '125x100!' }, 
  									:path => ":rails_root/public/images/:id/:filename", 
  									:url  => "/images/:id/:filename",
  									default_url: "/images/:style/vendor-1.jpg"

  # do_not_validate_attachment_file_type :listing
  validates_attachment_file_name :image, matches: [/png\Z/, /jpe?g\Z/]

end

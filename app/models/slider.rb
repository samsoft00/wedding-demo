class Slider < ActiveRecord::Base
	has_many :pictures, as: :imageable, dependent: :destroy
	belongs_to :site
	
	accepts_attachments_for :pictures, attachment: :image#pictures_image
	accepts_nested_attributes_for :pictures, allow_destroy: true, :reject_if => :all_blank

end

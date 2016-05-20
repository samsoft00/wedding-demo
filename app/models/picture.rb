class Picture < ActiveRecord::Base
	belongs_to :imageable, polymorphic: true
	attachment :image, type: :image, destroy: true

	after_destroy :remove_file
	# before_validation :generate_file_filename
	# before_save :set_dimensions, if: :file_id_changed?



	private

		def remove_file
			image.delete
		end

		def generate_file_filename
			extension = self.file_content_type == nil ? '' : Rack::Mime::MIME_TYPES.invert[self.file_content_type]
			filename = self.gallery.nil? || self.gallery.title.blank? ? 'photo' : self.gallery.title.parameterize
			self.file_filename = "#{filename}#{extension}"
		end

		def set_dimensions
		  image = MiniMagick::Image.open(image.to_io.to_io)#single to_io in production
		  self.width = image.width
		  self.height = image.height
		end		
	
end

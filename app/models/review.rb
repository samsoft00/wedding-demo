class Review < ActiveRecord::Base
	belongs_to :user
	belongs_to :listing

	validates :comment, :rating, :listing_id, :user_id, presence: true

end

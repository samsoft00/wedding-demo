class Category < ActiveRecord::Base
	has_and_belongs_to_many :listing
	has_one :type
	
end

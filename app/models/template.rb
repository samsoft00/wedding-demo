class Template < ActiveRecord::Base
	has_one :site
	has_many :colors

end

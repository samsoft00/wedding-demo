module SiteSetupHelper
	def vendor_options
		s = ''
		User.all.each do |user|
			s << "<option value='#{user.username}' data-img-src='#{gravatar_image_url(user.email, size: 50)}'>#{user.username}</option>"
		end
		s.html_safe
	end
end
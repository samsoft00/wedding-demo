class Wedding::ThemesController < ApplicationController
	skip_before_action :authenticate_user!, only: [:index]
	before_action :set_user
	theme 'basic'#:theme_resolver

	def index
	end

	private

		def theme_resolver
			@user.site.site_layout.name || 'default'
		end

		def set_user
			@user = User.find_by(username: request.subdomain)
			byebug
			redirect_to root_url if !@user.present? and @user.site.status.to_sym != :action
		end

end
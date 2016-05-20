class Wedding::SettingsController < ApplicationController
	before_action :is_site_active, :validate_url

	def index
	end


	private

    def validate_url
      if params[:username].present? && current_user.username != params[:username]
        redirect_to :action => :index, :username => current_user.username
      end
    end

end
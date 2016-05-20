class PagesController < ApplicationController
	skip_before_action :authenticate_user!, only: [:index]

	def index
	end

	def start_planning
		@template = Template.all()
	end

	def registration_confirmation_page
	end

	private

end
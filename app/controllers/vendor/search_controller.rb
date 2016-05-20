class Vendor::SearchController < ApplicationController
	skip_before_filter :authenticate_user!
	# before_filter :find_model

	def index
	end

	

	private
	def find_model
		@model = Search.find(params[:id]) if params[:id]
	end
end
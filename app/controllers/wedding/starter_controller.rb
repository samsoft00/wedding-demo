class StarterController < ApplicationController

	#Using Wicked Form
	include Wicked::Wizard



	private
	def find_model
		@model = Starter.find(params[:id]) if params[:id]
	end
end
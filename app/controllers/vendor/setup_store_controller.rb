class Vendor::SetupStoreController < ApplicationController
	before_action :set_profile, only: [:show, :update]

	#Using Wicked Form
	include Wicked::Wizard

	steps *Profile.form_steps#steps :business_info, :social, :location

	def show
		case step
		when "business_info"
			@profile = Profile.find(session[:profile_id])
		when "social"
			@profile = Profile.find(session[:profile_id])
		when "location"
			@profile = Profile.find(session[:profile_id])
		end

		render_wizard

	end

	def update
		case step
		when "business_info"
			@profile = Profile.find(session[:profile_id])
			@profile.update(profile_params(step))
			render_wizard @profile

		when "social"
			@profile = Profile.find(session[:profile_id])
			@profile.update(profile_params(step).merge(status: step.to_s))
			render_wizard @profile

		when "location"
			@profile = Profile.find(session[:profile_id])
			@profile.update(profile_params(step).merge(status: 'active'))
			current_user.update_attributes(is_vendor: true)
			session[:profile_id] = session["profile"] = nil 
			render_wizard @profile

		end		
	end

	private
		#:name, :business_name, :about, :phone, :website, :category_id, :facebook, :twitter, :instagram, :address, :city, :state, :country, :profile_image
		def profile_params(step)
			permitted_attributes = case step
			when "business_info"
				[:name, :business_name, :about, :phone, :services, :category_id]
			when "social"
				[:facebook, :twitter, :instagram, :website]
			when "location"
				[:address, :city, :state, :country]
			end

			params.require(:profile).permit(permitted_attributes).merge(form_step: step)
		end

		def set_profile
			# @profile = current_user.profile || Profile.new
		end

		def finish_wizard_path
			listings_path(current_user.username)
		end

end
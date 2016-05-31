class Vendor::SetupStoreController < ApplicationController
	before_action :initialize_profile, only: [:show, :update]
	skip_before_action :authenticate_user!

	#Using Wicked Form
	include Wicked::Wizard

	steps *Profile.form_steps#steps :business_info, :social, :location

	def show
		case step
		when "business_info"
			# @profile.build_user
		when "social"
			# @profile = Profile.find(session[:profile_id])
		when "location"

		end

		render_wizard 

	end

	def update
		case step
		when "business_info"
			@profile.assign_attributes(profile_params(step).merge(status: step.to_s))
			render_wizard @profile

		when "social"
			@profile.update(profile_params(step).merge(status: step.to_s))
			render_wizard @profile

		when "location"
			@profile.update(profile_params(step).merge(status: step.to_s))
			# current_user.update_attributes(is_vendor: true)
			# session[:profile_id] = session["profile"] = nil 
			render_wizard @profile

 		end


	end

	private
		#:name, :business_name, :about, :phone, :website, :category_id, :facebook, :twitter, :instagram, :address, :city, :state, :country, :profile_image
		def profile_params(step)
			permitted_attributes = case step
			when "business_info"
				[:business_name, :about, :phone, :services, :profile_image, :category_id, :username, :email]
			when "social"
				[:facebook, :twitter, :instagram, :website]
			when "location"
				[:address, :city, :state, :country]
			end

			params.require(:profile).permit(permitted_attributes).merge(form_step: step)
		end

		def initialize_profile
			if session[:profile_id].nil?
	    	@profile = Profile.new
	    	# @profile.user_id = current_user.id
	    	@profile.status = :start
	    	@profile.save(validate: false)
	    	session[:profile_id] = @profile.id
	    else
	    	@profile = Profile.find(session[:profile_id])
	    end
		end

		def finish_wizard_path
			if current_user
				listings_path(current_user.username)
			else

			end
		end

end
class Vendor::SetupStoreController < ApplicationController
	before_action :set_profile, only: [:show, :update]
	before_action :initialize_profile, only: [:show]
	skip_before_action :authenticate_user!

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
		when "user"
			@profile = Profile.find(12)
			# byebug
			
			if @profile.user.present?
				@user = @profile.user
			else
				@user = @profile.build_user
			end

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
			@profile.update(profile_params(step).merge(status: step.to_s))
			# current_user.update_attributes(is_vendor: true)
			# session[:profile_id] = session["profile"] = nil 
			render_wizard @profile

 		when "user"
	 		@profile = Profile.find(session[:profile_id])
	 		if !@profile.user.present?

	 			if @profile.status == "active"#previous step
		      user_record = @profile.build_user
		      user_record.username = params[:user][:username]
		      user_record.is_vendor = true
		      user_record.email = params[:user][:email].blank? ? "" : params[:user][:email]
		      user_record.password = params[:user][:password]
		    end

			end

	    # byebug
	    @profile.update(profile_params(step))
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
			when "user"
				[:username, :email, :password]
			end

			byebug

			params.require(:user).permit(permitted_attributes).merge(form_step: step)
		end

		def set_profile
			# @profile = current_user.profile || Profile.new
		end

		def initialize_profile
			if session[:profile_id].nil?
	    	@profile = Profile.new
	    	# @profile.user_id = current_user.id
	    	@profile.status = :start
	    	@profile.save(validate: false)
	    	session[:profile_id] = @profile.id
	    end
		end

		def finish_wizard_path
			if current_user
				listings_path(current_user.username)
			else

			end
		end

end
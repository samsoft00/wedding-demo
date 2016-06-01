class Vendor::SetupStoreController < ApplicationController
	before_action :initialize_profile, only: [:show, :update]
	skip_before_action :authenticate_user!

	#Using Wicked Form
	include Wicked::Wizard

	steps *Profile.form_steps#steps :business_info, :social, :location

	def show
		case step
		when "business_info"
			byebug
		when "social"
			# @profile = Profile.find(session[:profile_id])
		when "location"

		end

		render_wizard 

	end

	def update
		case step
		when "business_info"
			@profile.assign_attributes(profile_params(step).merge({status: step.to_s, c_user: current_user}))
			render_wizard @profile

		when "social"
			@profile.update(profile_params(step).merge(status: step.to_s))
			render_wizard @profile

		when "location"
			@profile.assign_attributes(profile_params(step).merge(status: 'active'))
			session[:profile_id] = session["profile"] = nil
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
			# @profile = Profile.find(session[:profile_id]) || Profile.new
			if session[:profile_id].nil?
	    	@profile = Profile.new || current_user.profile
	    else
	    	@profile = Profile.find(session[:profile_id])
	    end
		end

		def finish_wizard_path
			if current_user
				flash[:success] = "Profile Update Successfully!"
				listings_path(current_user.username)
			else
				flash[:info] = "Registration successful, kindly check your mail for confirmation email. Thanks"
				new_user_session_path
			end
		end

		#Copy: https://github.com/schneems/wicked/blob/master/lib/wicked/controller/concerns/render_redirect.rb
		def render_wizard(resource = nil, options = {})
	    process_resource!(resource)

	    if @skip_to
	      redirect_to wizard_path(@skip_to, @wicked_redirect_params || {}), options
	    else
	      render_step wizard_value(step), options
	    end

		end

	  def process_resource!(resource)
	    if resource
	      if resource.save
	      	session[:profile_id] = resource.id if session[:profile_id].nil?
	        @skip_to ||= @next_step
	      else
	        @skip_to = nil
	      end
	    end
	  end		

end
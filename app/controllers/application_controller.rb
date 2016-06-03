class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  
  helper_method :getVendorAddress, :is_site_active?, :permitted_to?
  # theme :theme_resolver

	#def after_sign_in_path_for(resource_or_scope)
	 #check request.referer then redirect.
	 #current_user_path
	#end

	#def after_sign_out_path_for(resource_or_scope)
	  #URI.parse(request.referer).path if request.referer
	#end

	# def render_404
	# 	render file: 'public/404.html', status: :not_found, layout: false
	# end

	# def render_error
	# 	render file: 'public/500.html', status: :internal_server_error, layout: false
	# end


	def getVendorAddress(profile)
		profile.address+' '+profile.city+ ', '+profile.state
	end

	def permitted_to? listing
		current_user.id == listing.user_id
	end

	protected

		def check_if_profile_created
			redirect_to  vendor_setup_store_index_path unless !current_user.profile.nil?
			# byebug
			#redirect
		end

		def is_site_active
			# wedding_settings_path(current_user.username) if current_user.site.status.to_sym != 'active'
		end

		def theme_resolver
		  subdomains = %w{www admin administrator subdomain user admin demo}
		  if request.subdomain.present? && !subdomains.include?(request.subdomain)
		  	@user = User.find_by(username: request.subdomain)
		  	return 'basic' if !@user.present? or !['action'].include?@user.site_status #show default
		  	return @user.site.site_layout.name
		  end
		  'application'
		end

		def after_sign_in_path_for(resource)
		  if resource.is_couple? and !resource.is_vendor?

		  	if !resource.site.done?

		  		if resource.site.status.nil?
		  			wedding_site_setup_path("couple-info")
		  		else
		  			steps = %w(couple-info our-story slider gallery)
		  			if steps.include?(resource.site.status)
		  				index = steps.index(resource.site.status.to_s)
		  				wedding_site_setup_path(steps[index+1].to_s)
		  			end
		  		end
		  		
		  	else
		  		wedding_settings_path
		  	end
  	 	elsif resource.is_vendor? and !resource.is_couple?
  	 		if !resource.profile.done?
  	 			session[:profile_id] = nil
  	 			initialize_profile(resource)
  	 		else
  	 			listings_path(resource.username)
  	 		end
  	 	else
  	 		display_vendor_listing_path
  	 	end

		end	

		def initialize_profile(resource)
	    posibilities = %w(business_info social location)
	    if posibilities.include?(resource.profile.status)
	    	index = posibilities.index(resource.profile.status.to_s)
	    	vendor_setup_store_path(posibilities[index+1].to_s)
	    else
	    	vendor_setup_store_index_path
	    end
		end	

end

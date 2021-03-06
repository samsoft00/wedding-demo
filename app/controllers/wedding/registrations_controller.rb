class Wedding::RegistrationsController < Devise::RegistrationsController
  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  # attr_accessible :username

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource, :location => wedding_sign_up_path(resource)
      # respond_with resource, :location => wedding_sign_up_path
    end
  end



  protected

    #This will never get call because of :confirmable
	 # def after_sign_up_path_for(resource)
	    #byebug
      #redirect to listings
	 # end

    #This will be call immediately after inactive call
    # def after_inactive_sign_up_path_for(resource)
    #   flash[:notice] = "Login Successfully, Please confirmed your email address"
    #   sign_in(resource_name, resource)
    #   yield resource if block_given?
    #   respond_with resource, location: after_sign_in_path_for(resource)
    # end    

	  def configure_devise_permitted_parameters

      if params[:action] == 'update'
        
        devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:title, :username, :first_name, :last_name, :bio, :avatar, :email, :password, :password_confirmation, :current_password) }

      elsif params[:action] == 'create'
        devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
      end

	  end

end
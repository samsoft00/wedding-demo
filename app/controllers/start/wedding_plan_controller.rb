class Start::WeddingPlanController < ApplicationController
	skip_before_action :authenticate_user!
	# before_filter :find_model

	#Using Wicked Form
	include Wicked::Wizard

	steps :'select-template', :'choose-plan', :register

	def show
		case step
		when :'select-template'
			session[:layout] = session[:package] = nil
			@templates = Template.paginate(:page => params[:page], :per_page => 6)
			@layout = SiteLayout.new
			
		when :'choose-plan'
			@packages = WeddingPackage.all()
			@weddingpackage = WeddingPackage.new
			session[:template] = params[:template_id] if params[:template_id].present?
			session[:package] = params[:package] if params[:package].present?

		when :register
			@template = Template.find(params[:template_id])
			@site = Site.new
		end

		render_wizard

	end


	def update
		case step
		when :'select-template'
			@layout = SiteLayout.new(layout_params)

			session[:layout] = @layout.id
			redirect_to next_wizard_path(template: @layout.id) and return
			
		when :'choose-plan'
			@packages = WeddingPackage.all()
			@weddingpackage = WeddingPackage.new(package_params)

			session[:package] = @weddingpackage.id
			redirect_to next_wizard_path(template: session[:layout], package: session[:package]) and return

		when :register
			@template = Template.find(session[:template])
			@site = Site.new(site_params.merge({form_step: step.to_s, c_user: current_user}))
			session[:layout] = session[:package] = nil if @site.valid?
			
			render_wizard @site and return

		end

	end
	

	private

		def finish_wizard_path
			#redirect to confirmation page
		  registration_confirmation_page_path(user_type: :wedding)
		end

		def layout_params
			params.require(:site_layout).permit(:id, :name, :color)
		end

		def package_params
			params.require(:wedding_package).permit(:id, :amount)
		end

		def site_params
			params.require(:site).permit(:bride_name, :groom_name, :wedding_date, :username, :email, :template_id, :wedding_package_id)
		end			

	  def check_errors(obj)
	    unless obj.valid?
	    	errors = []
	      obj.errors.each{|attr,msg| errors.push(attr.to_sym,"#{msg}")}
	      flash[:notice] = errors
	    end
	    redirect_to :back unless obj.errors.blank?
	  end		

end
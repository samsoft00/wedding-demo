class Wedding::SiteSetupController < ApplicationController
	# before_action :check_step#, :if => :user_site?
	before_action :set_site, only: [:update, :show]
	before_action :check_if_site_active

	#Using Wicked Form
	include Wicked::Wizard

	steps :'couple-info', :'our-story', :slider, :gallery
	respond_to :html

	def user_site?
		current_user.site.present? and session[:layout].present?
	end

	def show

		case step
			when :'couple-info'
				# @site = current_user.site || Site.new
				2.times {@site.wedding_location.build}# unless !@site.new_record?

			when :'our-story'
				@our_story = @site.our_story || OurStory.new

			when :slider
				@slider = @site.slider || Slider.new
				2.times {@slider.pictures.build} if @slider.new_record?

			when :gallery
				@gallary = @site.gallary || Gallary.new
				3.times {@gallary.pictures.build} if @gallary.new_record?

			end				

		render_wizard
	end

	def update
		case step
		when :'couple-info'
			if !@site.new_record?
				@site.assign_attributes(site_params.merge({status: step.to_s, form_step: "all", c_user: current_user}))

				render_wizard @site
			end

		when :'our-story'
			if !@site.our_story.nil?
				@site.our_story.update_attributes(our_story_params)
				redirect_to next_wizard_path
			else
				@story = OurStory.new(our_story_params)
				@story.site_id = current_user.site.id
				@story.site.update_attributes({status: step.to_s, c_user: current_user})
				render_wizard @story
			end
			
		when :slider
			if !@site.slider.nil?
				@site.slider.update_attributes(slider_params)
				redirect_to next_wizard_path #move to next_wizard
			else

				@slide = Slider.new(slider_params)
				@slide.site = current_user.site
				@slide.site.update_attributes(status: step.to_s)
				render_wizard @slide

			end

		when :gallery
			
			if !@site.gallary.nil?
				@site.gallary.update_attributes(gallery_params)
				 @site.update_attributes(status: 'active')
				redirect_to next_wizard_path #move to next_wizard
			else
				@gallery = Gallary.new(gallery_params)
				@gallery.site = current_user.site
				@gallery.site.update_attributes(status: 'active')#step.to_s
				flash[:notice] = "Congratulation, you've succuessful setup your pre-wedding website."
						# byebug
				render_wizard @gallery
			end
		
		end

	end

	private

		def lists_template
			@templates = Template.paginate(:page => params[:page])
		end

		def set_site
			@site = current_user.site
		end

		def finish_wizard_path
		  wedding_settings_path(current_user.username)
		end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_params
      params.require(:site).permit(:groom_name, :bride_name, :about_groom, :about_bride, :wedding_date, :photographer, :event_planner, :groom_image, :bride_image, wedding_location_attributes: [:id, :event_type, :date, :from, :to, :venue, :_destroy])
    end

    def our_story_params
    	params.require(:our_story).permit(:how_we_meet, :first_date, :proposal)
    end

		def slider_params
			params.require(:slider).permit(:remove_pictures_images, pictures_attributes: [:id,:image, :image_id, :description,:_destroy])
		end

		def gallery_params
			params.require(:gallary).permit(:remove_pictures_images, pictures_attributes: [:id,:image, :image_id, :description,:_destroy])
		end

    def check_step
    	if current_user.site.present? and current_user.site.status.to_sym != :active
    		@nxt_step = steps[steps.index(current_user.site.status.to_sym)+1]#get current step to determine the next step
    		if !@nxt_step.nil?
    			# redirect_to wizard_path(@next_step)
    			# render_step(@nxt_step)
    			# byebug
    			if current_user.site.status.to_sym == step
    				# redirect_to_next(@nxt_step)#nxt_step != current_step
    			end

    		elsif current_user.site.status.to_sym == steps.last
    			#which means user step
    			wizard_path(steps.last)
    		elsif current_user.site.status.to_sym == :active
    			#go to theme settings page
    		end
    			
    	end
    end

    def check_if_site_active
    	# redirect_to  wedding_settings_path(current_user.username) if current_user.site.present? and current_user.site.status.to_sym == :active
    end

end
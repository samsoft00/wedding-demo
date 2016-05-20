class Profile < ActiveRecord::Base
	before_save :check_social_params
	belongs_to :user
	has_many :category
  has_many :listing, dependent: :destroy

  cattr_accessor :form_steps do
    %w(business_info social location)
  end
   
  attr_accessor :form_step

  # has_attached_file :avatar, styles: { medium: "358x320#", thumb: "150x150#" }, default_url: "default.png"
  # validates :name, :business_name, :about, :phone, :services, :category_id, presence: true, if: -> { required_for_step?(:business_info)
  with_options if: -> { required_for_step?(:business_info) } do |step|
    step.validates :name, :business_name, :about, :services, :category_id, presence: true
    step.validates :phone, presence: true, 
                    numericality: { only_integer: true }, 
                    length: {minimum: 11}
  end    
  # validates :facebook, :twitter, :instagram, :website, presence: true, if: -> { required_for_step?(:social) }
  validates :address, :city, :state, :country, presence: true, if: -> { required_for_step?(:location) }
	# validates :name, :business_name, :about, :website, :category_id, :address, :city, :state, :country, presence: true


  attachment :profile_image, type: :image


  private

  	def check_social_params
  		# :facebook, :twitter, :instagram
  		self.facebook = '' if self.facebook.nil?
  		self.twitter = '' if self.twitter.nil?
  		self.instagram = '' if self.instagram.nil?
  	end

    def required_for_step?(step)
      # All fields are required if no form step is present
      return true if form_step.nil?

      # All fields from previous steps are required if the
      # step parameter appears before or we are on the current step
      return true if self.form_steps.index(step.to_s) <= self.form_steps.index(form_step.to_s)
    end    

end
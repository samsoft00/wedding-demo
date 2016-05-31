class Profile < ActiveRecord::Base
	before_save :check_social_params
	belongs_to :user
	has_many :category
  has_many :listing, dependent: :destroy

  cattr_accessor :form_steps do
    %w(business_info social location)
  end
   
  attr_accessor :form_step, :email, :username

  # has_attached_file :avatar, styles: { medium: "358x320#", thumb: "150x150#" }, default_url: "default.png"
  # validates :name, :business_name, :about, :phone, :services, :category_id, presence: true, if: -> { required_for_step?(:business_info)
  
  with_options :if => lambda { |o| o.form_step == "business_info" } do |step|
    step.validates :business_name, :about, :services, :category_id, presence: true
    step.validates :phone, presence: true, 
                    numericality: { only_integer: true },
                    length: {minimum: 11}

    step.validates_associated :user
    step.before_validation :create_user_and_validate
  end    
  # validates :facebook, :twitter, :instagram, :website, presence: true, if: -> { required_for_step?(:social) }
  validates :address, :city, :state, :country, presence: true, :if => lambda { |o| o.form_step == "location" }
	# validates :name, :business_name, :about, :website, :category_id, :address, :city, :state, :country, presence: true


  attachment :profile_image, type: :image


  def done?
    self.status == 'active'
  end

  def create_user_and_validate
    # byebug
    if self.status == 'business_info'#self.new_record?
      user_record = self.build_user
      user_record.username = self.username
      user_record.is_vendor = true
      user_record.email = self.email.blank? ? "" : self.email.to_s
      check_user_errors(user_record)
      return false unless errors.blank?
    # else
    #   self.user.is_vendor = true
    #   changes_to_be_checked = ['username','email']
    #   check_changes = self.changed & changes_to_be_checked
    #   unless check_changes.blank?
    #     self.user.username = self.username if check_changes.include?('username')
    #     self.user.email = self.email if check_changes.include?('email')
    #     check_user_errors(self.user)
    #   end
      
    end
    self.email = "" if self.email.blank?
    return false unless errors.blank?
  end

  def check_user_errors(user)
    unless user.valid?
      user.errors.each{|attr,msg| errors.add(attr.to_sym,"#{msg}")}
    end
    return false unless user.errors.blank?
  end

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
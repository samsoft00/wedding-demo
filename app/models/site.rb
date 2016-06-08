class Site < ActiveRecord::Base
  belongs_to :user

  has_one :template
  has_one :wedding_package
  has_one :our_story, dependent: :destroy
  has_one :site_layout, dependent: :destroy
  has_one :slider, dependent: :destroy
  has_one :gallary, dependent: :destroy

  attr_accessor :form_step, :email, :username, :c_user

  # has_many :pictures, as: :imageable
  has_many :rsvp, dependent: :destroy
  has_many :wedding_location, dependent: :destroy

  accepts_nested_attributes_for :wedding_location, :reject_if => :all_blank, :allow_destroy => true
  validates_associated :wedding_location

  # accepts_attachments_for :pictures, attachment: :image
  attachment :groom_image, type: :image
  attachment :bride_image, type: :image
 
  #validations :groom_name, :bride_name, :wedding_date
  validates :groom_name, :bride_name, :wedding_date, :about_groom, :about_bride, :photographer, :event_planner, presence: true, :if => lambda { |o| o.form_step == "all" }

  with_options :if => lambda { |o| o.form_step == "register" } do |step|
    step.validates :username, :email, :wedding_date, :bride_name, :groom_name, :template_id, :wedding_package_id, presence: true

    step.validates_associated :user, if: -> { c_user.nil? }
    step.before_validation :create_user_and_validate, if: -> { c_user.nil? }
  end   

  def done?
    self.status == 'active'
  end
  
  def create_user_and_validate
    # byebug
    user_record = self.build_user
    user_record.username = self.username
    user_record.is_couple = true
    user_record.email = self.email.blank? ? "" : self.email.to_s
    check_user_errors(user_record)
    return false unless errors.blank?

    self.email = "" if self.email.blank?
    return false unless errors.blank?
  end

  def check_user_errors(user)
    unless user.valid?
      user.errors.each{|attr,msg| errors.add(attr.to_sym,"#{msg}")}
    end
    return false unless user.errors.blank?
  end

end

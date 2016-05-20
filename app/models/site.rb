class Site < ActiveRecord::Base
  belongs_to :user
  belongs_to :template

  has_one :our_story, dependent: :destroy
  has_one :site_layout, dependent: :destroy
  has_one :slider, dependent: :destroy
  has_one :gallary, dependent: :destroy

  # has_many :pictures, as: :imageable
  has_many :rsvp, dependent: :destroy
  has_many :wedding_location, dependent: :destroy

  accepts_nested_attributes_for :wedding_location, :reject_if => :all_blank, :allow_destroy => true
  validates_associated :wedding_location

  # accepts_attachments_for :pictures, attachment: :image
  attachment :groom_image, type: :image
  attachment :bride_image, type: :image

  #validations
  validates :groom_name, :bride_name, :about_groom, :about_bride, :wedding_date, :photographer, :event_planner, presence: true
end

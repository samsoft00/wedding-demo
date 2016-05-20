class Listing < ActiveRecord::Base
	extend FriendlyId

	LISTING_STATUS = %w(active pending modification draft denied paused)

	friendly_id :name, use: :slugged
  before_save :check_listing_params

	has_and_belongs_to_many :category
	has_many :faq, :dependent => :destroy
	has_many :listing_image, :dependent => :destroy
	has_many :reviews, :dependent => :destroy
	has_many :pictures, as: :imageable, dependent: :destroy
	belongs_to :profile
	belongs_to :user
	
	#lambda {|a| a[:key].blank?}
	accepts_nested_attributes_for :faq, :reject_if => :all_blank, :allow_destroy => true
	# accepts_nested_attributes_for :listing_image, :allow_destroy => true, :reject_if => :all_blank

	accepts_attachments_for :pictures, attachment: :image#pictures_image
	accepts_nested_attributes_for :pictures, allow_destroy: true, :reject_if => :all_blank	

	validates :name, presence: true
	validates_associated :faq

	scope :active, -> {where(:status => 'active')}
	scope :pending, -> { where(:status => 'pending') }
	scope :modification, -> { where(:status => 'modification') }
	scope :draft, -> { where(:status => 'draft') }
	scope :denied, -> { where(:status => 'denied') }
	scope :paused, -> { where(:status => 'paused') }

  def check_listing_params
    if self.new_record?
      self.pricing_and_faq = '' if self.pricing_and_faq.blank?
    end
  end

  def rate
  	if self.reviews.present?
    	self.reviews.average(:rating).round(2)
    end
    0
  end

end

class WeddingLocation < ActiveRecord::Base
  belongs_to :site

  validates :event_type, :date, :from, :to, :venue, presence: true
end

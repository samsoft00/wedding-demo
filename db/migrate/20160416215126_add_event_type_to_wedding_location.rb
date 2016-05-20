class AddEventTypeToWeddingLocation < ActiveRecord::Migration
  def change
    add_column :wedding_locations, :event_type, :string
  end
end

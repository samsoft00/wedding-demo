json.array!(@sites) do |site|
  json.extract! site, :id, :groom_name, :bride_name, :about_groom, :about_bride, :wedding_date, :photographer, :event_planner, :user_id, :template_id
  json.url site_url(site, format: :json)
end

json.array!(@profiles) do |profile|
  json.extract! profile, :id, :name, :business_name, :phone, :website, :facebook, :twitter, :instagram, :address
  json.url profile_url(profile, format: :json)
end

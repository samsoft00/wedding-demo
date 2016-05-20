json.array!(@listings) do |listing|
  json.extract! listing, :id, :name, :details, :slug, :category_id, :pricing_and_faq
  json.url listing_url(listing, format: :json)
end

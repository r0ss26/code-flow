json.extract! listing, :id, :title, :category, :description, :price, :delivery_time, :active, :created_at, :updated_at
json.url listing_url(listing, format: :json)

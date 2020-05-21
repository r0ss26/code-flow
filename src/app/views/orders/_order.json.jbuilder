json.extract! order, :id, :listing_id, :cost, :paid, :completed, :buyer, :seller, :created_at, :updated_at
json.url order_url(order, format: :json)

json.extract! review, :id, :order_id, :rating, :description, :review_poster_id, :review_receiver_id, :created_at, :updated_at
json.url review_url(review, format: :json)

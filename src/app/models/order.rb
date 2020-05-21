class Order < ApplicationRecord
  validates :cost, :buyer_id, :seller_id, presence: true
  belongs_to :buyer, class_name: "User"
  belongs_to :seller, class_name: "User"
  belongs_to :listing, counter_cache: :orders_count
  has_one :review, dependent: :destroy
end

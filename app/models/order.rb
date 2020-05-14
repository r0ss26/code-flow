class Order < ApplicationRecord
  validates :listing_id, :cost, :paid, :completed, :buyer_id, :seller_id, presence: true
  belongs_to :buyer, class_name: "User"
  belongs_to :seller, class_name: "User"
  belongs_to :listing
  has_one :review
end

class Review < ApplicationRecord
  validates :order_id, :user_id, :rating, :description, presence: true
  belongs_to :order
  belongs_to :user
end

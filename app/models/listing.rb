class Listing < ApplicationRecord
  validates :user_id, :title, :category_id, :description, :price, :delivery_time, presence: true
  belongs_to :user
  belongs_to :category
  has_many :orders
end

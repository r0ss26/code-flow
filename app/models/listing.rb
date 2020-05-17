class Listing < ApplicationRecord
  validates :user_id, :title, :category_id, :description, :price, :delivery_time, presence: true
  validates :price, numericality: {greater_than: 0}
  belongs_to :user
  belongs_to :category
  has_many :orders
  has_one_attached :image

end

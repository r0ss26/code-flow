class Listing < ApplicationRecord
  validates :user_id, :title, :category_id, :description, :price, :delivery_time, presence: true
  validates :price, numericality: {greater_than: 0}
  validates :delivery_time, numericality: {greater_than: 0}
  belongs_to :user
  belongs_to :category
  has_many :orders, dependent: :nullify
  has_one_attached :image, dependent: :destroy
  acts_as_favoritable
  acts_as_taggable_on :tags
end
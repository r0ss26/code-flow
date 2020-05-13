class Order < ApplicationRecord
  belongs_to :user
  belongs_to :listing
  has_one :review
end

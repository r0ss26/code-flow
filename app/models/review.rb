class Review < ApplicationRecord
  validates :order_id, :user_id, :rating, :description, presence: true
  belongs_to :order
  belongs_to :user
  belongs_to :reviewer, class_name: "User"
  belongs_to :receiver, class_name: "User"
end

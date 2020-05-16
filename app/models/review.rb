class Review < ApplicationRecord
  validates :rating, :description, :review_poster_id, :review_receiver_id, presence: true
  validate :cannot_review_self
  belongs_to :order
  belongs_to :review_poster, class_name: "User"
  belongs_to :review_receiver, class_name: "User"

  def cannot_review_self
    errors.add(:review_receiver_id, "You cannot review your own listing.") if review_receiver_id == review_poster_id
  end
end

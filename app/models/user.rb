class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :employments
  has_many :educations
  has_many :listings
  has_many :sales, class_name: "Order", foreign_key: "seller_id"
  has_many :purchases, class_name: "Order", foreign_key: "buyer_id"
  has_many :reviews
  has_many :received_reviews, class_name: "Review", foreign_key: "review_receiver_id"
  has_many :posted_reviews, class_name: "Review", foreign_key: "review_poster_id"
  has_one_attached :image
  acts_as_favoritor
end

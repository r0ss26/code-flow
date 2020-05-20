class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :employments, dependent: :destroy
  has_many :educations, dependent: :destroy
  has_many :listings, dependent: :destroy
  has_many :sales, class_name: "Order", foreign_key: "seller_id", dependent: :nullify
  has_many :purchases, class_name: "Order", foreign_key: "buyer_id", dependent: :nullify
  has_many :received_reviews, class_name: "Review", foreign_key: "review_receiver_id", dependent: :destroy
  has_many :posted_reviews, class_name: "Review", foreign_key: "review_poster_id", dependent: :destroy
  has_one_attached :image, dependent: :destroy
  acts_as_favoritor
end

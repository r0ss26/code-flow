class Education < ApplicationRecord
  validates :user_id, :school, :degree, :start_date, :end_date, presence: true
  validate :end_date_after_start_date
  belongs_to :user
end

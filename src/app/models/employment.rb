class Employment < ApplicationRecord
  validates :user_id, :company, :position, :start_date, :end_date, presence: true
  validate :end_date_after_start_date
  belongs_to :user
end

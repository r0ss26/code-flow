class Employment < ApplicationRecord
  validates :user_id, :company, :position, :start_date, :end_date, presence: true
  belongs_to :user
end

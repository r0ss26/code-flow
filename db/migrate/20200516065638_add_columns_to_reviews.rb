class AddColumnsToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :reviewer_id, :integer
    add_column :reviews, :receiver_id, :integer
  end
end

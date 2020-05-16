class FixColumnNameReviews < ActiveRecord::Migration[5.2]
  def change
    rename_column :reviews, :reviewer_id, :review_poster_id
    rename_column :reviews, :receiver_id, :review_receiver_id
  end
end

class AddNotNullActiveToListings < ActiveRecord::Migration[5.2]
  def change
    change_column_null :listings, :active, false
    change_column_default :listings, :active, true
  end
end

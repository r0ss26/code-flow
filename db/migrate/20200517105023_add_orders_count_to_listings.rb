class AddOrdersCountToListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :orders_count, :integer
  end
end

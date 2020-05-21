class AddFieldsToOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :user_id
    add_reference :orders, :buyer, references: :users, index: true
    add_reference :orders, :seller, references: :users, index: true
  end
end

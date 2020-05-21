class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.references :listing, foreign_key: true
      t.integer :cost, {null: false}
      t.boolean :paid, {null: false, default: false}
      t.boolean :completed, {null: false, default: false}

      t.timestamps
    end
  end
end

class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.references :category, foreign_key: true
      t.text :description
      t.integer :price
      t.integer :delivery_time
      t.boolean :active

      t.timestamps
    end
  end
end

class CreateEmployments < ActiveRecord::Migration[5.2]
  def change
    create_table :employments do |t|
      t.references :user, foreign_key: true
      t.string :company, {null: false}
      t.string :position, {null: false}
      t.date :start_date, {null: false}
      t.date :end_date

      t.timestamps
    end
  end
end

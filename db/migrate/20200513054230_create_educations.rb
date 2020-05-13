class CreateEducations < ActiveRecord::Migration[5.2]
  def change
    create_table :educations do |t|
      t.references :user, foreign_key: true
      t.string :school
      t.string :degree
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end

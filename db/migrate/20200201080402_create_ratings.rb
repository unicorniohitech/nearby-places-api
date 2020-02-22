class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :place, null: false, foreign_key: true
      t.string :comment
      t.float :score
      t.datetime :deleted_at

      t.timestamps
    end
  end
end

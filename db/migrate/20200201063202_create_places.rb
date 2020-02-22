class CreatePlaces < ActiveRecord::Migration[5.1]
  def change
    create_table :places do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :cnpj
      t.string :address
      t.string :country
      t.string :city
      t.string :state_code
      t.float :latitude
      t.float :longitude
      t.floar :rating_avg
      t.float :total_rating, default: 0
      t.datetime :deleted_at

      t.timestamps
    end
  end
end

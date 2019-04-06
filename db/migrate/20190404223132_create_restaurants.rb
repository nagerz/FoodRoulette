class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :yelp_id
      t.string :name
      t.string :address_1
      t.string :address_2
      t.string :address_3
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :country
      t.string :phone
      t.text :image_url
      t.float :rating
      t.string :price
      t.float :latitude
      t.float :longitude
      t.integer :reviews
      t.string :category_1
      t.string :category_2
      t.string :category_3

      t.timestamps
    end
  end
end

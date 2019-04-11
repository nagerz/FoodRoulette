class RestaurantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :address_1, :city, :state, :latitude, :longitude

  attribute :address do |restaurant|
    restaurant.address_1 + " " + restaurant.city + ", " + restaurant.state
  end
end

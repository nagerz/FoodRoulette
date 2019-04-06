FactoryBot.define do
  factory :restaurant do
    sequence(:yelp_id) { |n| "yelp_id_#{n}" }
    name { "Resto Name" }
    address_1  { "123 Address St." }
    price { "$$" }
    category_1 { "Spanish" }
    rating { "4" }
    longitude { 98.6 }
    latitude { -5.6 }
  end
end

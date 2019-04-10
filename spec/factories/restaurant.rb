FactoryBot.define do
  factory :restaurant do
    sequence(:yelp_id) { |n| "yelp_id_#{n}" }
    sequence(:name) { |n| "Resto Name_#{n}" }
    address_1  { "123 Address St." }
    price { "$$" }
    category_1 { "Spanish" }
    rating { "4" }
    longitude { 98.6 }
    latitude { -5.6 }
    url { "https://www.yelp.com/biz/los-chingones-denver-denver-2" }
  end
end

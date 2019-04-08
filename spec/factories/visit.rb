FactoryBot.define do
  factory :visit do
    user
    restaurant
    longitude { 98.6 }
    latitude { -5.6 }
  end
end

FactoryBot.define do
  factory :visit do
    user
    restaurant
    latitude { 39.755459608447 }
    longitude { -104.988913938884 }
  end
end

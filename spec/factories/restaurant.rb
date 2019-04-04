FactoryBot.define do
  factory :restaurant do
    name { "Resto Name" }
    address  { "123 Address St." }
    price_range { "$$" }
    cuisine { "Spanish" }
    rating { "4" }
    distance { 0.81 }
    hours { "M-F, 9AM-5PM" }
  end
end

FactoryBot.define do
  factory :recommendation do
    name { "Resto Name" }
    address  { "123 Address St." }
    price_range { "$$" }
    cuisine { "Spanish" }
    rating { "4" }
    hours { "M-F, 9AM-5PM" }
  end
end

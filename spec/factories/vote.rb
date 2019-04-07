FactoryBot.define do
  factory :vote do
    survey_restaurant
    value { 1 }
    voter { 555 }
  end
end

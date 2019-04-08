FactoryBot.define do
  factory :phone_number do
    survey
    sequence(:digits) { |n| "number_#{n}" }
  end
end

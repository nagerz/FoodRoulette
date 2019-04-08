FactoryBot.define do
  factory :phone_number do
    survey
    sequence(:digits) { |n| "+1222333444#{n}" }
  end
end

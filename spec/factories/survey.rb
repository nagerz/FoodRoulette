FactoryBot.define do
  factory :survey do
    user
    phone_numbers { "[123, 456, 789]" }
  end
end

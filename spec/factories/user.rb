FactoryBot.define do
  factory :user do
    sequence(:google_id) { |n| "Id_#{n}" }
    sequence(:first_name) { |n| "User_#{n}" }
    last_name { "Name" }
    sequence(:email) { |n| "user_#{n}@email.com" }
    sequence(:token) { |n| "user_#{n}_token" }
    sequence(:refresh_token) { |n| "user_#{n}_refresh_token" }
    sequence(:thumbnail) { "https://banner2.kisspng.com/20180410/bbw/kisspng-avatar-user-medicine-surgery-patient-avatar-5acc9f7a7cb983.0104600115233596105109.jpg" }
  end

  factory :admin, parent: :user do
    role { :admin }
  end
end

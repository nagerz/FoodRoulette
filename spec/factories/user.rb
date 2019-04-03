FactoryBot.define do
  factory :user do
    google_id { "google id" }
    first_name  { "John" }
    last_name { "Doe" }
    email { "jdoe@gmail.com" }
    token { "token" }
  end
end

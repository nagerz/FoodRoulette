# frozen_string_literal: true

FactoryBot.define do
  factory :vote do
    survey
    survey_restaurant
    phone_number
  end
end

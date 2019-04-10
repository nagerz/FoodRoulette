# frozen_string_literal: true

FactoryBot.define do
  factory :survey do
    user
    status { 0 }
  end
end

class Survey < ApplicationRecord
  belongs_to :user
  has_many :survey_restaurants
  has_many :restaurants, through: :survey_restaurants
  attr_accessor :sender, :event, :date_time, :restaurant_1, :restaurant_2, :restaurant_3
end

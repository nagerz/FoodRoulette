class SurveyRestaurant < ApplicationRecord
  belongs_to :survey
  belongs_to :restaurant
  has_many :votes
end

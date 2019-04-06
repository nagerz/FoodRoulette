class SurveyRestaurant < ApplicationRecord
  belongs_to :survey
  belongs_to :restaurant
end

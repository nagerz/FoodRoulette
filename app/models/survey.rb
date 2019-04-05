class Survey < ApplicationRecord
  belongs_to :user
  has_many :survey_restaurants
  has_many :restaurants, through: :survey_restaurants
end

class Restaurant < ApplicationRecord
  has_many :survey_restaurants
  has_many :visits
  has_many :users, through: :visits

  validates :yelp_id, uniqueness: true, presence: true
  validates_presence_of :name
  validates_presence_of :latitude
  validates_presence_of :longitude
  validates_presence_of :price
  validates_presence_of :rating
  validates_presence_of :category_1
  validates_presence_of :image_url

end

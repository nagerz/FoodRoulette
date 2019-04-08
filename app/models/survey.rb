class Survey < ApplicationRecord
  attr_accessor :sender, :event, :date_time, :restaurant_1, :restaurant_2, :restaurant_3

  belongs_to :user
  has_many :survey_restaurants
  has_many :restaurants, through: :survey_restaurants
  has_many :votes
  has_many :phone_numbers

  enum status: %i[active inactive]

  def unique_vote?(phone_number_digits)
    Vote.joins(:phone_number).where(survey: self.id, phone_numbers: {digits: phone_number_digits}).empty?
  end

  def find_survey_restaurant(response)
    index = response.to_i - 1
    self.survey_restaurants[index]
  end

  def check_end_survey
    if votes.count == phone_numbers.count
      end_survey
    end
  end

  def end_survey
    update_attribute(:status, 1)
    #close channel?
  end

  # def tally_ranks
#     survey_restaurants = SurveyRestaurant.joins(:votes)
#                                          .select('survey_restaurants.*, count(votes) as restaurant_votes')
#                                          .group(:id)
#                                          .order("restaurant_votes desc")
# binding.pry
#     survey_restaurants.each do |survey_restaurant|
#       rank = survey_restaurants.index(survey_restaurant) + 1
#       survey_restaurant.update_attribute(:rank, rank)
    # end
end

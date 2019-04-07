class Survey < ApplicationRecord
  attr_accessor :sender, :event, :date_time, :restaurant_1, :restaurant_2, :restaurant_3

  belongs_to :user
  has_many :survey_restaurants
  has_many :restaurants, through: :survey_restaurants

  enum status: %i[active inactive]

  #vote model
  def find_survey
    #most recent survey where incoming number is one of the outgoing numbers
  end

  #vote model
  def unique_vote?
    #true if all survey.votes.number do not match the incoming number
  end

  #vote model
  def add_survey_restaurant(response, survey)
    index = response.to_i - 1
    survey.survey_restaurants[index]
    survey_restaurant.update_attribute(:vote, vote)
  end

  #instance method on found survey
  def check_status
    numbers_sent = phone_numbers.split(",").count
    if votes.count = numbers_sent
      end_survey
    end
  end

  def end_survey
    update_attribute(:status, 1)
    tally_ranks
    #close channel?
  end

  def tally_ranks
    #select survey_restaurants where survey = survey
    #order by total vote count desc
    survey_restaurants.sort_by {|restaurant| restaurant.votes.count }
    survey_restaurants.each do |survey_restaurant|
      rank = survey_restaurants.index(survey_restaurant)
      update_attribute(:rank, rank)
    end
  end
end

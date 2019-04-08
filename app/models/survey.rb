class Survey < ApplicationRecord
  attr_accessor :sender, :event, :date_time, :restaurant_1, :restaurant_2, :restaurant_3

  belongs_to :user
  has_many :survey_restaurants
  has_many :restaurants, through: :survey_restaurants

  enum status: %i[active inactive]

  def unique_vote?(phone_number)
    !Vote.where(survey: self.id, phone_number: phone_number)
  end

  def find_survey_restaurant(response)
    index = response.to_i - 1
    self.survey_restaurants[index]
  end

  def check_end_survey
    numbers_sent = sent_phone_numbers.count
    votes_received = received_votes.count
    if votes_received = numbers_sent
      end_survey
    end
  end

  def sent_phone_numbers
    PhoneNumber.where(survey: self.id)
  end

  def received_votes
    Vote.where(survey: self.id)
  end

  def end_survey
    update_attribute(:status, 1)
    tally_ranks
    #close channel?
  end

  def tally_ranks
    #select survey_restaurants where survey = survey
    #order by total vote count desc
    survey_restaurants = SurveyRestaurant.joins(:votes)
                                         .select('survey_restaurants.*, sum(votes) as restaurant_votes')
                                         .group(:id)
                                         .order("restaurant_votes desc")

    survey_restaurants.each do |survey_restaurant|
      rank = survey_restaurants.index(survey_restaurant) + 1
      update_attribute(:rank, rank)
    end
  end
end

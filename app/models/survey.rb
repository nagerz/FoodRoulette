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
    if votes.count == phone_numbers.count + 1
      end_survey
    end
  end

  def end_survey
    update_attribute(:status, 1)

    #TwilioTextMessenger.new.send_survey_result(self.id)
    #close channel?
  end

  def winner
    survey_restaurants.joins(:votes)
        .group('survey_restaurants.id')
        .select("survey_restaurants.*, count(votes.id) as vote_count")
        .order("vote_count desc")
        .first.restaurant
  end

end

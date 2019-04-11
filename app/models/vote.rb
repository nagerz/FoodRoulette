# frozen_string_literal: true

class Vote < ApplicationRecord
  belongs_to :survey
  belongs_to :survey_restaurant
  belongs_to :phone_number, optional: true

  def self.create_vote(phone_number_string, restaurant, survey)
    if phone_number_string
      text_vote(phone_number_string, restaurant, survey)
    else
      user_vote(restaurant, survey)
    end
  end

  def self.text_vote(phone_number_string, response, survey)
    if valid_response?(response)
      if survey.active? && survey.unique_vote?(phone_number_string)
        ValidResponseTextJob.perform_later(phone_number_string, survey)
        response = response.to_i
        phone_number = PhoneNumber.find_by(digits: phone_number_string)
        survey_restaurant = survey.find_survey_restaurant(response)
        vote = Vote.new(phone_number: phone_number, survey: survey, survey_restaurant: survey_restaurant)
        if vote.save
          survey.check_end_survey
          vote
        end
      end
    else
      InvalidResponseTextJob.perform_later(phone_number_string)
    end
  end

  def self.user_vote(survey_restaurant_id, survey)
    if survey.active?
      survey_restaurant = SurveyRestaurant.find(survey_restaurant_id)
      vote = Vote.new(survey: survey, survey_restaurant: survey_restaurant)
      if vote.save
        survey.check_end_survey
        vote
      end
    end
  end

  def self.valid_response?(response)
    if response.empty? || response.length != 1 || !response.to_i.between?(1, 3)
      false
    else
      true
    end
  end
end

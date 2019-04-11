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
        send_valid_vote_text(phone_number_string, survey)
        vote = new_vote(phone_number_string, response, survey)
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

  def self.send_valid_vote_text(phone_number_string, survey)
    path = "surveys/"
    url = create_url(path, survey)
    ValidResponseTextJob.perform_later(phone_number_string, survey, url)
  end

  def self.new_vote(phone_number_digits, response, survey)
    phone_number = PhoneNumber.find_by(digits: phone_number_digits)
    survey_restaurant = survey.find_survey_restaurant(response.to_i)
    Vote.new(phone_number: phone_number, survey: survey, survey_restaurant: survey_restaurant)
  end

  def self.create_url(path, object)
    client = Bitly.client
    domain = "https://calm-tundra-59037.herokuapp.com/"
    url = domain + path + object.id.to_s
    client.shorten(url).short_url
  end

end

class Vote < ApplicationRecord
  belongs_to :survey
  belongs_to :survey_restaurant
  belongs_to :phone_number

  def self.create_vote(phone_number_string, response)
    if valid_response?(response)
      response = response.to_i
      phone_number = PhoneNumber.find_by(digits: phone_number_string)
      survey = phone_number.survey
      if survey.unique_vote?(phone_number_string)
        survey_restaurant = survey.find_survey_restaurant(response)
        if survey.active?
          vote = Vote.new(phone_number: phone_number, survey: survey, survey_restaurant: survey_restaurant)
          if vote.save
            survey.check_end_survey
            vote
          end
        end
      end
    else
      send_invalid_response_text(phone_number_string, response)
    end

  end

  def self.valid_response?(response)
    if response.empty? || response.length != 1 || !response.to_i.between?(1,3)
      false
    else
      true
    end
  end

  def self.send_invalid_response_text(phone_number_string, response)
  end
end

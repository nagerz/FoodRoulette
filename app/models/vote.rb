class Vote < ApplicationRecord
  after_create_commit {VoteBroadcastJob.perform_later self}
  # belongs_to :survey

  def self.create_vote(phone_number_string, response)
    if valid_response?(response)
      phone_number = PhoneNumber.find_by(digits: phone_number_string)
      survey = phone_number.survey
      if survey.unique_vote?(phone_number)
        survey_restaurant = survey.find_survey_restaurant(response)
        if survey.active?
          vote = Vote.new(phone_number: phone_number, survey: survey, survey_restaurant: survey_restaurant)
          if vote.save
            survey.check_end_survey
          end
        end
      end
    end
  end

  def valid_response?(response)
  end
end

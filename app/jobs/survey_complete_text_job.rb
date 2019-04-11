# frozen_string_literal: true

class SurveyCompleteTextJob < ApplicationJob
  queue_as :default

  def perform(survey_id, url)
    TwilioTextMessenger.new.send_survey_result(survey_id, url)
  end
end

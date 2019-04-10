class SurveyCompleteTextJob < ApplicationJob
  queue_as :default

  def perform(survey_id)
    TwilioTextMessenger.new.send_survey_result(survey_id)
  end
end

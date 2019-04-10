class CreateSurveyTextJob < ApplicationJob
  queue_as :default

  def perform(survey_data)
    TwilioTextMessenger.new.send_survey(survey_data)
  end
end

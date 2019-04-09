class SurveyFacade < SimpleDelegator

  def initialize(survey)
    super(survey)
    @survey = survey
  end

  def status
    if @survey.active?
      "Survey is still active"
    else
      "Survey is Over"
    end
  end

  def user_phone_number
  end

end

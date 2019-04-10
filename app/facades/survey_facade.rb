class SurveyFacade < SimpleDelegator

  def initialize(survey)
    super(survey)
    @survey = survey
  end

  def status
    if @survey.active?
      "Active"
    else
      "Closed"
    end
  end

  def winner
    @survey.winner
  end

end

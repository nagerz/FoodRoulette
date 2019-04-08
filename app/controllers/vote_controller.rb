class VoteController < ApplicationController

  def index
    survey = Survey.find(params[:survey])

    render locals: {
      facade: SurveyFacade.new(survey)
    }
  end
end

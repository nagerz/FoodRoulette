class SurveysController < ApplicationController

  def new
    @survey = Survey.new
    @restaurant_1 = params["restaurant_1"]
    @restaurant_2 = params["restaurant_2"]
    @restaurant_3 = params["restaurant_3"]
  end

  def create
    binding.pry
    data = { }
    data[:sender] = survey_params[:sender]
    data[:phone_numbers] = survey_params[:phone_numbers]
    data[:event] = survey_params[:event]
    data[:date_time] = survey_params[:date_time]
    data[:restaurant_1] = survey_params[:restaurant_1]
    data[:restaurant_2] = survey_params[:restaurant_2]
    data[:restaurant_3] = survey_params[:restaurant_3]

    TwilioTextMessenger.new(data).send_survey

    @survey = Survey.new(user_id: current_user.id, phone_numbers: survey_params[:phone_numbers])
    if survey.save
      redirect_to survey_path(@survey)
      flash[:success] = "Your survey has been sent!"
    else
      flash[:alert] = "We're sorry. You're survey could not be sent at this time."
      redirect_to root_path
    end
  end

  private

  def survey_params
    params.require(:survey).permit(:sender, :phone_numbers, :restaurant_1, :restaurant_2, :restaurant_3, :event, :date_time)
  end
end

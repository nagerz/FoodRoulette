class SurveysController < ApplicationController

   def show
     survey = Survey.find(params[:id])

     render locals: {
       facade: SurveyFacade.new(survey)
     }
   end

   def new
     @survey = Survey.new
     @restaurant_1 = params["restaurant_1"]
     @restaurant_2 = params["restaurant_2"]
     @restaurant_3 = params["restaurant_3"]
   end

   def create
     data = { }
     data[:sender] = survey_params[:sender]
     data[:phone_numbers] = parse_phone_numbers(survey_params[:phone_numbers])
     data[:event] = survey_params[:event]
     data[:date_time] = survey_params[:date_time]
     data[:restaurant_1] = survey_params[:restaurant_1]
     data[:restaurant_2] = survey_params[:restaurant_2]
     data[:restaurant_3] = survey_params[:restaurant_3]
     restaurant_names = [survey_params[:restaurant_1], survey_params[:restaurant_2], survey_params[:restaurant_3]]

     TwilioTextMessenger.new.send_survey(data)

     @survey = Survey.new(user_id: current_user.id)

     if @survey.save
       data[:phone_numbers].each do |number|
         PhoneNumber.create(digits: number, survey: @survey)
       end

       restaurant_names.each do |restaurant_name|
         restaurant = Restaurant.find_by(name: restaurant_name)
         @survey.survey_restaurants.create(restaurant: restaurant)
       end

       redirect_to survey_path(@survey)
       flash[:success] = "Your survey has been sent!"
     else
       redirect_to root_path
       flash[:alert] = "We're sorry. You're survey could not be sent at this time."
     end
   end

  def update
    survey = Survey.find(params[:id])

    Vote.create_vote(params[:phone], params[:restaurant_code])
    redirect_to survey_path(survey)
  end

   private

  def survey_params
    params.require(:survey).permit(:sender, :phone_numbers, :restaurant_1, :restaurant_2, :restaurant_3, :event, :date_time)
  end

  def parse_phone_numbers(phone_numbers)
    numbers = phone_numbers.split(/\s*,\s*/)
    numbers.map { |number| "+1" + number}
  end
end

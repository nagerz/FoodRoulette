require 'factory_bot_rails'

include FactoryBot::Syntax::Methods

User.destroy_all
Survey.destroy_all
Restaurant.destroy_all
SurveyRestaurant.destroy_all
PhoneNumber.destroy_all
Vote.destroy_all

@user = create(:user)
@survey1 = create(:survey, user: @user, status: 0)
@survey2 = create(:survey, user: @user, status: 0)
@restaurant1 = create(:restaurant)
@restaurant2 = create(:restaurant)
@restaurant3 = create(:restaurant)
@survey_restaurant1 = create(:survey_restaurant, survey: @survey1, restaurant: @restaurant1)
@survey_restaurant2 = create(:survey_restaurant, survey: @survey1, restaurant: @restaurant2)
@survey_restaurant3 = create(:survey_restaurant, survey: @survey1, restaurant: @restaurant3)
@survey_restaurant4 = create(:survey_restaurant, survey: @survey2, restaurant: @restaurant1)
@survey_restaurant5 = create(:survey_restaurant, survey: @survey2, restaurant: @restaurant2)
@survey_restaurant6 = create(:survey_restaurant, survey: @survey2, restaurant: @restaurant3)
@phone_number1 = create(:phone_number, digits: "+12223334444", survey: @survey1)
@phone_number2 = create(:phone_number, digits: "+15556667777", survey: @survey1)
@phone_number3 = create(:phone_number, digits: "+12223334444", survey: @survey2)
@phone_number4 = create(:phone_number, digits: "+15556667777", survey: @survey2)
@vote1 = create(:vote, survey: @survey1, phone_number: @phone_number1, survey_restaurant: @survey_restaurant1)
@vote2 = create(:vote, survey: @survey2, phone_number: @phone_number3, survey_restaurant: @survey_restaurant5)
@vote3 = create(:vote, survey: @survey2, phone_number: @phone_number4, survey_restaurant: @survey_restaurant5)
@active_survey = create(:survey, user: @user, status: 0)
@inactive_survey = create(:survey, user: @user, status: 1)

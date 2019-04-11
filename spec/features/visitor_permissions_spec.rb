# frozen_string_literal: true

require 'rails_helper'

describe 'As a visitor' do
  it 'I cannot access any page on the site besides the login and survey page' do
    visit '/'

    expect(current_path).to eq(login_path)

    visit '/login'

    expect(current_path).to eq(login_path)

    visit '/roulette'

    expect(current_path).to eq(login_path)

    visit '/roulettes'

    expect(current_path).to eq(login_path)

    visit '/directions'

    expect(current_path).to eq(login_path)

    visit '/vote/1'

    expect(current_path).to eq(login_path)

    visit '/profile'

    expect(current_path).to eq(login_path)

    visit '/about'

    expect(current_path).to eq(login_path)
  end

  it 'I can visit a survey results page but I cannot end the survey' do
    @user = create(:user)
    @restaurant_1 = create(:restaurant)
    @restaurant_2 = create(:restaurant)
    @restaurant_3 = create(:restaurant)
    @restaurant_4 = create(:restaurant)
    @survey = create(:survey, user: @user)
    @survey_2 = create(:survey, user: @user)
    @phone_1 = create(:phone_number, survey: @survey)
    @phone_2 = create(:phone_number, survey: @survey)
    @phone_3 = create(:phone_number, survey: @survey)
    @phone_4 = create(:phone_number, survey: @survey, digits: '+12223334444')
    @sr_1 = @survey.survey_restaurants.create(restaurant: @restaurant_1)
    @sr_2 = @survey.survey_restaurants.create(restaurant: @restaurant_2)
    @sr_3 = @survey.survey_restaurants.create(restaurant: @restaurant_3)

    visit survey_path(@survey)

    expect(current_path).to eq(survey_path(@survey))
    expect(page).to_not have_button('End Survey Now')
  end
end

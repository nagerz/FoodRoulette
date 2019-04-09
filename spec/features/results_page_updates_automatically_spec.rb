require 'rails_helper'

describe 'As a user, when I visit a survey results page' do
  xit 'the vote count for each restaurant will update without refreshing', :js do
    user = create(:user)
    survey = create(:survey)
    restaurant1 = create(:restaurant)
    restaurant2 = create(:restaurant)
    restaurant3 = create(:restaurant)
    phone1 = create(:phone_number, survey: survey)
    phone2 = create(:phone_number, survey: survey)
    phone3 = create(:phone_number, survey: survey)
    sr1 = create(:survey_restaurant, survey: survey, restaurant: restaurant1)
    sr2 = create(:survey_restaurant, survey: survey, restaurant: restaurant2)
    sr3 = create(:survey_restaurant, survey: survey, restaurant: restaurant3)

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(user)

    visit survey_path(survey)

    expect(page).to have_content('Total Votes Received: 0')

    within(".survey-restaurant-#{sr1.id}") do
      expect(page).to have_content('Votes received: 0')
    end

    create(:vote, survey: survey, survey_restaurant: sr1, phone_number: phone1)

    sleep(2)

    expect(page).to have_content('Total Votes Received: 1')
    expect(page).to have_content('Votes received: 1')
  end
end

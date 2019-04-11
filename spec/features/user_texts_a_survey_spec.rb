# frozen_string_literal: true

require 'rails_helper'

describe 'As a user' do
  context 'When I complete the survey data form and send survey' do
    it 'sends a survey text to mulitple numbers', :vcr do
      user = create(:user)
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(user)

      url = 'https://api.yelp.com/v3/businesses/search?categories=restaurants&limit=50&location=Denver,%20CO&open_now=true&price=1,2&radius=8000'
      filename = 'survey_random_roulette_response.json'
      stub_get_json(url, filename)

      visit root_path

      set_location('Denver, CO')

      click_button 'Survey them!'

      click_on 'Send to Friends'

      expect(current_path).to eq(new_survey_path)
      fill_in 'Your Name:', with: 'ADag'
      field = "Your Friends' Phone Numbers (e.g. '2223334444,5556667777'):"
      fill_in field, with: '1234567899,9876543211'
      fill_in 'Event Name:', with: "Julia's bday!"
      fill_in 'Date/Time of Event (optional):', with: 'This weekend?'

      click_on 'Send Text'

      survey = Survey.last

      expect(current_path).to eq(vote_path(survey))
      expect(page).to have_content('Your survey has been sent!')
      expect(page).to have_content('Vote for your choice:')
    end

    it 'saves survey restaurants', :vcr do
      user = create(:user)
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(user)

      url = 'https://api.yelp.com/v3/businesses/search?categories=restaurants&limit=50&location=Denver,%20CO&open_now=true&price=1,2&radius=8000'
      filename = 'survey_random_roulette_response.json'
      stub_get_json(url, filename)

      visit root_path

      set_location('Denver, CO')

      click_button 'Survey them!'

      click_on 'Send to Friends'

      expect(current_path).to eq(new_survey_path)

      expect(Survey.count).to eq(0)
      expect(SurveyRestaurant.count).to eq(0)

      fill_in 'Your Name:', with: 'ADag'
      field = "Your Friends' Phone Numbers (e.g. '2223334444,5556667777'):"
      fill_in field, with: '1234567899,9876543211'
      fill_in 'Event Name:', with: "Julia's bday!"
      fill_in 'Date/Time of Event (optional):', with: 'This weekend?'

      click_on 'Send Text'

      survey = Survey.last

      expect(current_path).to eq(vote_path(survey))

      expect(Survey.count).to eq(1)
      expect(SurveyRestaurant.count).to eq(3)

      expect(survey.survey_restaurants.count).to eq(3)

      expected_rest_ids = []
      survey.survey_restaurants.each do |restaurant|
        expected_rest_ids << restaurant.restaurant_id
      end

      expect(expected_rest_ids).to include(Restaurant.first.id)
      expect(expected_rest_ids).to include(Restaurant.second.id)
      expect(expected_rest_ids).to include(Restaurant.third.id)

      expect(page).to have_content('Your survey has been sent!')
    end
  end
end

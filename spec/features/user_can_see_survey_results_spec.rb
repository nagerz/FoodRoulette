# frozen_string_literal: true

require 'rails_helper'

describe 'As a user' do
  context 'After I send a group survey' do
    before :each do
      @user = create(:user)
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(@user)

      @restaurant1 = create(:restaurant)
      @restaurant2 = create(:restaurant)
      @restaurant3 = create(:restaurant)
      @restaurant4 = create(:restaurant)

      @survey = create(:survey, user: @user)
      @survey2 = create(:survey, user: @user)

      @phone1 = create(:phone_number, survey: @survey)
      @phone2 = create(:phone_number, survey: @survey)
      @phone3 = create(:phone_number, survey: @survey)
      @phone4 = create(:phone_number, survey: @survey, digits: '+12223334444')

      @sr1 = @survey.survey_restaurants.create(restaurant: @restaurant1)
      @sr2 = @survey.survey_restaurants.create(restaurant: @restaurant2)
      @sr3 = @survey.survey_restaurants.create(restaurant: @restaurant3)
    end

    it 'I can see the survey results page' do
      visit survey_path(@survey)

      expect(page).to have_content('Status: Active')
      expect(page).to have_content('Total Votes Received:')

      expect(page).to have_content(@restaurant1.name.to_s)
      expect(page).to have_content(@restaurant2.name.to_s)
      expect(page).to have_content(@restaurant3.name.to_s)
      expect(page).to_not have_content(@restaurant4.name.to_s)

      expect(page).to have_css('.survey-restaurant', count: 3)

      within(".survey-restaurant-#{@sr1.id}") do
        expect(page).to have_content(@restaurant1.name.to_s)
        expect(page).to have_content('Votes received:')
      end

      expect(page).to have_button('End Survey Now')
    end

    it 'page updates with votes' do
      # rubocop:disable Metrics/LineLength
      @vote1 = create(:vote, survey: @survey, phone_number: @phone1, survey_restaurant: @sr1)
      @vote2 = create(:vote, survey: @survey, phone_number: @phone2, survey_restaurant: @sr1)
      @vote3 = create(:vote, survey: @survey, phone_number: @phone3, survey_restaurant: @sr3)
      # rubocop:enable Metrics/LineLength

      visit survey_path(@survey)

      expect(page).to have_content('Status: Active')
      expect(page).to have_content('Total Votes Received:')

      within(".survey-restaurant-#{@sr1.id}") do
        expect(page).to have_content('Votes received:')
      end

      within(".survey-restaurant-#{@sr2.id}") do
        expect(page).to have_content('Votes received:')
      end

      within(".survey-restaurant-#{@sr3.id}") do
        expect(page).to have_content('Votes received:')
      end
    end

    it 'I can end the survey by button', :vcr do
      # rubocop:disable Metrics/LineLength
      @vote1 = create(:vote, survey: @survey, phone_number: @phone1, survey_restaurant: @sr1)
      @vote2 = create(:vote, survey: @survey, phone_number: @phone2, survey_restaurant: @sr3)
      @vote3 = create(:vote, survey: @survey, phone_number: @phone3, survey_restaurant: @sr3)
      # rubocop:enable Metrics/LineLength

      visit survey_path(@survey)

      expect(page).to have_content('Status: Active')
      expect(page).to have_content('Total Votes Received:')

      within(".survey-restaurant-#{@sr1.id}") do
        expect(page).to have_content('Votes received:')
      end

      within(".survey-restaurant-#{@sr3.id}") do
        expect(page).to have_content('Votes received:')
      end

      expect(page).to have_button('End Survey Now')

      click_button 'End Survey Now'
      visit survey_path(@survey)

      expect(current_path).to eq(survey_path(@survey))

      expect(page).to have_content('Status: Closed')
      expect(page).to have_content('Total Votes Received:')

      message = "#{@restaurant3.name} received the most votes!"
      expect(page).to have_content(message)

      expect(page).to have_button('Take Me There')
      expect(page).to have_button('Start Another Survey')

      expect(page).to_not have_button('End Survey Now')
    end
  end
end

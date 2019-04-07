require 'rails_helper'

describe "As a user" do
  context "After I send a group survey" do
    it "I can see the survey results page" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      restaurant_1 = create(:restaurant)
      restaurant_2 = create(:restaurant)
      restaurant_3 = create(:restaurant)
      restaurant_4 = create(:restaurant)

      survey = create(:survey)

      sr_1 = survey.survey_restaurants.create(restaurant: restaurant_1)
      sr_2 = survey.survey_restaurants.create(restaurant: restaurant_2)
      sr_3 = survey.survey_restaurants.create(restaurant: restaurant_3)

      visit survey_path(survey)

      expect(page).to have_content("Survey results! Watch them roll in...")
      expect(page).to have_content("Survey status: Survey is still active")
      expect(page).to have_content("Total Votes Received: 0")

      expect(page).to have_content("#{restaurant_1.name}")
      expect(page).to have_content("#{restaurant_2.name}")
      expect(page).to have_content("#{restaurant_3.name}")
      expect(page).to_not have_content("#{restaurant_4.name}")

      expect(page).to have_css('.survey-restaurant', count: 3)

      within(".survey-restaurant-#{sr_1.id}") do
        expect(page).to have_content("#{restaurant_1.name}")
        expect(page).to have_content("Votes recieved: 0")

        expect(page).to have_button('Vote for this')
      end

      expect(page).to have_button('End Survey Now')
    end
  end
end

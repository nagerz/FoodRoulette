require 'rails_helper'

describe "As a user" do
  context "After I complete the survey data form and send survey" do
    it "I see a voting page with the correct options" do
      @user = create(:user)
      @survey1 = create(:survey, user: @user)
      @restaurant1 = create(:restaurant)
      @restaurant2 = create(:restaurant)
      @restaurant3 = create(:restaurant)
      @sr1 = create(:survey_restaurant, survey: @survey1, restaurant: @restaurant1)
      @sr2 = create(:survey_restaurant, survey: @survey1, restaurant: @restaurant2)
      @sr3 = create(:survey_restaurant, survey: @survey1, restaurant: @restaurant3)
      @phone_number1 = create(:phone_number, digits: "+12223334444", survey: @survey1)
      @phone_number2 = create(:phone_number, digits: "+13334445555", survey: @survey1)
      @phone_number3 = create(:phone_number, digits: "+14445556666", survey: @survey1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      url = "https://api.yelp.com/v3/businesses/search?categories=restaurants&limit=50&location=Denver,%20CO&open_now=true&price=1,2&radius=8000"
      filename = "survey_random_roulette_response.json"
      stub_get_json(url, filename)

      visit vote_path(@survey1)

      expect(current_path).to eq(vote_path(@survey1))

      expect(page).to have_content("Vote for your choice!")

      expect(page).to have_content("#{@restaurant1.name}")
      expect(page).to have_content("#{@restaurant2.name}")
      expect(page).to have_content("#{@restaurant3.name}")

      expect(page).to have_css('.survey-restaurant', count: 3)

      within(".survey-restaurant-#{@sr1.id}") do
        expect(page).to have_content("#{@restaurant1.name}")

        expect(page).to have_button('Vote for this')
      end

      expect(page).to have_button('Cancel Survey')
    end
  end
end

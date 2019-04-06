require 'rails_helper'

describe "As a user" do
  context "When I complete the survey data form and send survey" do
    it "sends a survey text to mulitple numbers", :vcr do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      url = "https://api.yelp.com/v3/businesses/search?categories=restaurants&limit=50&location=Denver,%20CO&open_now=true&price=1,2&radius=8000"
      filename = "survey_random_roulette_response.json"
      stub_get_json(url, filename)

      # url = "https://api.twilio.com/2010-04-01/Accounts/ACe3da591e4a18d595dd6c00b3052ecd6c/Messages.json"
      # filename = "survey_text_response.json"
      # stub_post_json(url, filename)

      visit root_path

      set_location('Denver, CO')

      click_button 'Survey them!'

      click_on "Send to Friends"

      expect(current_path).to eq(new_survey_path)

      fill_in "Your Name:", with: "ADag"
      fill_in "Your Friends' Phone Numbers (e.g. '+12223334444,+15556667777'):", with: "+19097540068,+17155740144"
      fill_in "Event Name:", with: "Julia's bday!"
      fill_in "Date/Time of Event (optional):", with: "This weekend?"

      click_on "Send Text"

      survey = Survey.last

      expect(current_path).to eq("/surveys/#{survey.id}")
      expect(page).to have_content("Your survey has been sent!")
      expect(page).to have_content("Survey results! Watch them roll in...")
    end

    it "saves survey restaurants", :vcr do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      url = "https://api.yelp.com/v3/businesses/search?categories=restaurants&limit=50&location=Denver,%20CO&open_now=true&price=1,2&radius=8000"
      filename = "survey_random_roulette_response.json"
      stub_get_json(url, filename)

      visit root_path

      set_location('Denver, CO')

      click_button 'Survey them!'

      click_on "Send to Friends"

      expect(current_path).to eq(new_survey_path)

      expect(Survey.count).to eq(0)
      expect(SurveyRestaurant.count).to eq(0)

      fill_in "Your Name:", with: "ADag"
      fill_in "Your Friends' Phone Numbers (e.g. '+12223334444,+15556667777'):", with: "+19097540068,+17155740144"
      fill_in "Event Name:", with: "Julia's bday!"
      fill_in "Date/Time of Event (optional):", with: "This weekend?"

      click_on "Send Text"

      survey = Survey.last

      expect(current_path).to eq(survey_path(survey))

      expect(Survey.count).to eq(1)
      expect(SurveyRestaurant.count).to eq(3)

      expect(survey.survey_restaurants.count).to eq(3)

      expected_ids = []
      survey.survey_restaurants.each do |restaurant|
        expected_ids << restaurant.restaurant_id
      end

      expect(expected_ids).to include(Restaurant.first.id)
      expect(expected_ids).to include(Restaurant.second.id)
      expect(expected_ids).to include(Restaurant.third.id)

      expect(page).to have_content("Your survey has been sent!")
      expect(page).to have_content("Survey results! Watch them roll in...")
    end
  end
end



# As a visitor, when I click on “Survey Friends” and click on “Send to Friends,”
# I see a page to enter their phone numbers, an event name, and a date/time, as well as a button to “Send Text”.
# At that time, a text message will go out to all the phone numbers I have entered.
# The text should read something like below.
# The text also contains a link to the survey results at “/surveys/:id”
#
# April has requested your input on where to eat for “Julia’s Birthday” at 7pm on May 4, 2019. To vote for Syrup Cafe, text reply with “1”. To vote for Rio, text reply with “2”. To vote for Illegal Pete’s, text reply with “3”.

require 'rails_helper'

describe "As a user" do
  context "I can send a survey to my friends" do
    it "by entering the survey data into a form" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit group_roulette_path
      click_on "Send to Friends"

      expect(current_path).to eq("/surveys/new")

      fill_in :phone_numbers, with: "+19097540068,+17155740144"

      click_on "Send Text"
      survey = Survey.last
      expect(current_path).to eq("/surveys/#{survey.id}")


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

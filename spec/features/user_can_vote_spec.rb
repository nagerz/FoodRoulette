# frozen_string_literal: true

require 'rails_helper'

describe 'As a user', :vcr do
  context 'After I complete the survey data form and send survey' do
    before :each do
      @user = create(:user)
      @survey1 = create(:survey, user: @user)
      @restaurant1 = create(:restaurant)
      @restaurant2 = create(:restaurant)
      @restaurant3 = create(:restaurant)
      @sr1 = create(:survey_restaurant, survey: @survey1, restaurant: @restaurant1)
      @sr2 = create(:survey_restaurant, survey: @survey1, restaurant: @restaurant2)
      @sr3 = create(:survey_restaurant, survey: @survey1, restaurant: @restaurant3)

      url = 'https://api.yelp.com/v3/businesses/search?categories=restaurants&limit=50&location=Denver,%20CO&open_now=true&price=1,2&radius=8000'
      filename = 'survey_random_roulette_response.json'
      stub_get_json(url, filename)

      url = "http://api.bit.ly/v3/shorten?apiKey=#{ENV['BITLY_API_KEY']}&login=#{ENV['BITLY_LOGIN']}&longUrl=https://localhost:3000/surveys/#{@survey1.id}"
      filename = 'bitly_response.json'
      stub_get_json(url, filename)
    end

    context 'As the user creator' do
      before :each do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      end

      it 'I see a voting page with the correct options' do
        visit vote_path(@survey1)

        expect(current_path).to eq(vote_path(@survey1))

        expect(page).to have_content('Vote for your choice:')

        expect(page).to have_content(@restaurant1.name.to_s)
        expect(page).to have_content(@restaurant2.name.to_s)
        expect(page).to have_content(@restaurant3.name.to_s)

        expect(page).to have_css('.survey-restaurant', count: 3)

        within(".survey-restaurant-#{@sr1.id}") do
          expect(page).to have_content(@restaurant1.name.to_s)
          expect(page).to have_button("Vote for #{@restaurant1.name}")
        end

        expect(page).to have_button('Cancel Survey')
      end

      it 'I can vote for my choice' do
        visit vote_path(@survey1)

        expect(current_path).to eq(vote_path(@survey1))

        expect(Vote.count).to eq(0)

        within(".survey-restaurant-#{@sr1.id}") do
          expect(page).to have_content(@restaurant1.name.to_s)

          expect(page).to have_button("Vote for #{@restaurant1.name}")

          click_button("Vote for #{@restaurant1.name}")
        end

        expect(current_path).to eq(survey_path(@survey1))

        expect(Vote.count).to eq(1)
        expect(Vote.last.survey_restaurant).to eq(@sr1)

        expect(page).to have_content('Your vote has been cast')
      end

      it "I can't vote twice" do
        visit vote_path(@survey1)

        expect(Vote.count).to eq(0)

        expect(current_path).to eq(vote_path(@survey1))

        within(".survey-restaurant-#{@sr1.id}") do
          expect(page).to have_content(@restaurant1.name.to_s)

          expect(page).to have_button("Vote for #{@restaurant1.name}")

          click_button("Vote for #{@restaurant1.name}")
        end

        expect(Vote.count).to eq(1)

        expect(current_path).to eq(survey_path(@survey1))

        expect(page).to have_content('Your vote has been cast')

        visit vote_path(@survey1)

        expect(current_path).to eq(survey_path(@survey1))

        expect(page).to have_content("You've already voted!")
      end

      it 'I can cancel survey' do
        visit vote_path(@survey1)

        expect(current_path).to eq(vote_path(@survey1))

        expect(Vote.count).to eq(0)

        expect(page).to have_button('Cancel Survey')

        click_button 'Cancel Survey'

        expect(current_path).to eq(root_path)

        expect(Vote.count).to eq(0)

        expect(page).to have_content('Your survey has been cancelled.')
      end
    end

    it 'I get a 404 if I am not the survey creator' do
      user = create(:user)
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(user)
      visit vote_path(@survey1)

      expect(page).to have_content("The page you're looking for could not be found.")
    end
  end
end

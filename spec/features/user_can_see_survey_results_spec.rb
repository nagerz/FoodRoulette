require 'rails_helper'

describe "As a user" do
  context "After I send a group survey" do
    before :each do
      @user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      @restaurant_1 = create(:restaurant)
      @restaurant_2 = create(:restaurant)
      @restaurant_3 = create(:restaurant)
      @restaurant_4 = create(:restaurant)

      @survey = create(:survey)
      @survey_2 = create(:survey)

      @phone_1 = create(:phone_number, survey: @survey)
      @phone_2 = create(:phone_number, survey: @survey)
      @phone_3 = create(:phone_number, survey: @survey, digits: "+12223334444")

      @sr_1 = @survey.survey_restaurants.create(restaurant: @restaurant_1)
      @sr_2 = @survey.survey_restaurants.create(restaurant: @restaurant_2)
      @sr_3 = @survey.survey_restaurants.create(restaurant: @restaurant_3)
    end

    it "I can see the survey results page" do

      visit survey_path(@survey)

      expect(page).to have_content("Survey results! Watch them roll in...")
      expect(page).to have_content("Survey status: Survey is still active")
      expect(page).to have_content("Total Votes Received: 0")

      expect(page).to have_content("#{@restaurant_1.name}")
      expect(page).to have_content("#{@restaurant_2.name}")
      expect(page).to have_content("#{@restaurant_3.name}")
      expect(page).to_not have_content("#{@restaurant_4.name}")

      expect(page).to have_css('.survey-restaurant', count: 3)

      within(".survey-restaurant-#{@sr_1.id}") do
        expect(page).to have_content("#{@restaurant_1.name}")
        expect(page).to have_content("Votes received: 0")

        expect(page).to have_button('Vote for this')
      end

      expect(page).to have_button('End Survey Now')
    end

    it "page updates with votes" do
      @vote1 = create(:vote, survey: @survey, phone_number: @phone_1, survey_restaurant: @sr_1)
      @vote2 = create(:vote, survey: @survey, phone_number: @phone_2, survey_restaurant: @sr_1)
      #@vote5 = create(:vote, survey: @survey_2, phone_number: @phone_number1, survey_restaurant: @sr_1)

      visit survey_path(@survey)

      expect(page).to have_content("Survey status: Survey is still active")
      expect(page).to have_content("Total Votes Received: 2")

      within(".survey-restaurant-#{@sr_1.id}") do
        expect(page).to have_content("Votes received: 2")

        expect(page).to have_button('Vote for this')
      end

      within(".survey-restaurant-#{@sr_2.id}") do
        expect(page).to have_content("Votes received: 0")

        expect(page).to have_button('Vote for this')
      end

      # @vote3 = create(:vote, survey: @survey, phone_number: @phone_3, survey_restaurant: @sr_2)
      #
      # visit survey_path(@survey)
      #
      # expect(current_path).to eq(survey_path(@survey))
      #
      # expect(page).to have_content("Survey status: Survey is Over")
      # expect(page).to have_content("Total Votes Received: 3")
      #
      # within(".survey-restaurant-#{@sr_1.id}") do
      #   expect(page).to have_content("Votes recieved: 1")
      #
      #   expect(page).to have_button('Vote for this')
      # end
      #
      # within(".survey-restaurant-#{@sr_2.id}") do
      #   expect(page).to have_content("Votes recieved: 1")
      #
      #   expect(page).to have_button('Vote for this')
      # end
      #
      # expect(page).to_not have_button('End Survey Now')
    end

    it "I can see the survey results page after vote by button" do
      @vote1 = create(:vote, survey: @survey, phone_number: @phone_1, survey_restaurant: @sr_1)

      visit survey_path(@survey)

      expect(page).to have_content("Survey results! Watch them roll in...")
      expect(page).to have_content("Survey status: Survey is still active")
      expect(page).to have_content("Total Votes Received: 1")

      expect(page).to have_content("#{@restaurant_1.name}")
      expect(page).to have_content("#{@restaurant_2.name}")
      expect(page).to have_content("#{@restaurant_3.name}")
      expect(page).to_not have_content("#{@restaurant_4.name}")

      expect(page).to have_css('.survey-restaurant', count: 3)

      within(".survey-restaurant-#{@sr_1.id}") do
        expect(page).to have_content("#{@restaurant_1.name}")
        expect(page).to have_content("Votes received: 1")

        expect(page).to have_button('Vote for this')
      end

      within(".survey-restaurant-#{@sr_2.id}") do
        expect(page).to have_content("#{@restaurant_2.name}")
        expect(page).to have_content("Votes received: 0")

        expect(page).to have_button('Vote for this')

        click_button('Vote for this')
      end

      expect(current_path).to eq(survey_path(@survey))

      expect(page).to have_content("Survey status: Survey is still active")
      expect(page).to have_content("Total Votes Received: 2")

      within(".survey-restaurant-#{@sr_1.id}") do
        expect(page).to have_content("#{@restaurant_1.name}")
        expect(page).to have_content("Votes received: 1")

        expect(page).to have_button('Vote for this')
      end

      within(".survey-restaurant-#{@sr_2.id}") do
        expect(page).to have_content("#{@restaurant_2.name}")
        expect(page).to have_content("Votes received: 1")

        expect(page).to have_button('Vote for this')
      end

      expect(page).to have_button('End Survey Now')
    end
  end
end

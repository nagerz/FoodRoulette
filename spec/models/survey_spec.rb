# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Survey, type: :model do
  describe 'relationships' do
    it { should belong_to(:user) }
    it { should have_many(:survey_restaurants) }
    it { should have_many(:restaurants).through(:survey_restaurants) }
  end

  describe 'instance methods', :vcr do
    before :each do
      @user = create(:user)
      @survey1 = create(:survey, user: @user, status: 0)
      @survey2 = create(:survey, user: @user, status: 0)
      @restaurant1 = create(:restaurant)
      @restaurant2 = create(:restaurant)
      @restaurant3 = create(:restaurant)
      @survey_restaurant1 = create(:survey_restaurant, survey: @survey1, restaurant: @restaurant1)
      @survey_restaurant2 = create(:survey_restaurant, survey: @survey1, restaurant: @restaurant2)
      @survey_restaurant3 = create(:survey_restaurant, survey: @survey1, restaurant: @restaurant3)
      @survey_restaurant4 = create(:survey_restaurant, survey: @survey2, restaurant: @restaurant1)
      @survey_restaurant5 = create(:survey_restaurant, survey: @survey2, restaurant: @restaurant2)
      @survey_restaurant6 = create(:survey_restaurant, survey: @survey2, restaurant: @restaurant3)
      @phone_number1 = create(:phone_number, digits: '+12223334444', survey: @survey1)
      @phone_number2 = create(:phone_number, digits: '+15556667777', survey: @survey1)
      @phone_number3 = create(:phone_number, digits: '+12223334444', survey: @survey2)
      @phone_number4 = create(:phone_number, digits: '+15556667777', survey: @survey2)
      @vote1 = create(:vote, survey: @survey1, phone_number: @phone_number1, survey_restaurant: @survey_restaurant1)
      @vote2 = create(:vote, survey: @survey2, phone_number: @phone_number3, survey_restaurant: @survey_restaurant5)
      @vote3 = create(:vote, survey: @survey2, phone_number: @phone_number4, survey_restaurant: @survey_restaurant5)
      @vote4 = create(:vote, survey: @survey2, survey_restaurant: @survey_restaurant6)
      @active_survey = create(:survey, user: @user, status: 0)
      @inactive_survey = create(:survey, user: @user, status: 1)


    end

    it '#unique_vote?' do
      expect(@survey1.unique_vote?('+12223334444')).to eq(false)
      expect(@survey1.unique_vote?('+15556667777')).to eq(true)
    end

    it '#active?' do
      expect(@active_survey.active?).to eq(true)
      expect(@inactive_survey.active?).to eq(false)
    end

    it '#find_survey_restaurant' do
      expect(@survey1.find_survey_restaurant('3')).to eq(@survey_restaurant3)
      expect(@survey1.find_survey_restaurant('1')).to eq(@survey_restaurant1)
      expect(@survey1.find_survey_restaurant('2')).to eq(@survey_restaurant2)
    end

    it '#check_end_survey' do
      @survey1.check_end_survey
      expect(@survey1.status).to eq('active')
      # expect(@survey1.survey_restaurants[0].rank).to eq(nil)
      # expect(@survey1.survey_restaurants[1].rank).to eq(nil)
      # expect(@survey1.survey_restaurants[2].rank).to eq(nil)

      @survey2.check_end_survey
      expect(@survey2.status).to eq('inactive')
      # expect(@survey2.survey_restaurants[0].rank).to eq(2)
      # expect(@survey2.survey_restaurants[1].rank).to eq(1)
      # expect(@survey2.survey_restaurants[2].rank).to eq(3)
    end
  end
end

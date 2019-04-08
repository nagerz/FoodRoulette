require 'rails_helper'

RSpec.describe Survey, type: :model do
  describe 'relationships' do
    it { should belong_to(:user) }
    it { should have_many(:survey_restaurants) }
    it { should have_many(:restaurants).through(:survey_restaurants) }
  end

  describe "instance methods" do
    before :each do
      @user = create(:user)
      @survey = create(:survey, user: @user, status: 0)
      @restaurant1 = create(:restaurant)
      @restaurant2 = create(:restaurant)
      @restaurant3 = create(:restaurant)
      @survey_restaurant1 = create(:survey_restaurant, survey: @survey, restaurant: @restaurant1)
      @survey_restaurant2 = create(:survey_restaurant, survey: @survey, restaurant: @restaurant2)
      @survey_restaurant3 = create(:survey_restaurant, survey: @survey, restaurant: @restaurant3)
      @phone_number = create(:phone_number, digits: "+12223334444", survey: @survey)
      @vote = create(:vote, survey: @survey, phone_number: @phone_number, survey_restaurant: @survey_restaurant1)
      @active_survey = create(:survey, user: @user, status: 0)
      @inactive_survey = create(:survey, user: @user, status: 1)
    end

    it "#unique_vote?" do
      expect(@survey.unique_vote?("+12223334444")).to eq(false)
      expect(@survey.unique_vote?("+15556667777")).to eq(true)
    end

    it "#active?" do
      expect(@active_survey.active?).to eq(true)
      expect(@inactive_survey.active?).to eq(false)
    end

    it "#find_survey_restaurant" do
      expect(@survey.find_survey_restaurant("3")).to eq(@survey_restaurant3)
      expect(@survey.find_survey_restaurant("1")).to eq(@survey_restaurant1)
      expect(@survey.find_survey_restaurant("2")).to eq(@survey_restaurant2)
    end
  end

end

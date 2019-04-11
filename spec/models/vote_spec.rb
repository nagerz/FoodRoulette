# frozen_string_literal: true

require 'rails_helper'

describe Vote, type: :model do
  describe 'class methods' do
    before :each do
      @user = create(:user)
      @survey1 = create(:survey, user: @user, status: 0)
      @survey2 = create(:survey, user: @user, status: 0)
      @restaurant1 = create(:restaurant)
      @restaurant2 = create(:restaurant)
      @restaurant3 = create(:restaurant)
      # rubocop:disable Metrics/LineLength
      @survey_restaurant1 = create(:survey_restaurant, survey: @survey1, restaurant: @restaurant1)
      @survey_restaurant2 = create(:survey_restaurant, survey: @survey1, restaurant: @restaurant2)
      @survey_restaurant3 = create(:survey_restaurant, survey: @survey1, restaurant: @restaurant3)
      @phone_number1 = create(:phone_number, digits: '+12223334444', survey: @survey1)
      @phone_number2 = create(:phone_number, digits: '+15556667777', survey: @survey1)
      @vote1 = create(:vote, survey: @survey1, phone_number: @phone_number1, survey_restaurant: @survey_restaurant1)
      # rubocop:enable Metrics/LineLength
    end

    it '.text_vote' do
      duplicate_vote = Vote.create_vote('+12223334444', '1', @survey1)
      expect(duplicate_vote).to eq(nil)

      invalid_response = Vote.create_vote('+15556667777', '5', @survey1)
      expect(invalid_response).to be_a(InvalidResponseTextJob)

      unique_vote = Vote.create_vote('+15556667777', '2', @survey1)
      expect(unique_vote).to be_a(Vote)
      expect(unique_vote.survey_restaurant).to eq(@survey_restaurant2)
      expect(unique_vote.survey).to eq(@survey1)
      expect(unique_vote.phone_number).to eq(@phone_number2)
    end

    it '.user_vote' do
      unique_vote = Vote.create_vote(nil, @survey_restaurant2.id, @survey1)
      expect(unique_vote).to be_a(Vote)
      expect(unique_vote.survey_restaurant).to eq(@survey_restaurant2)
      expect(unique_vote.survey).to eq(@survey1)
      expect(unique_vote.phone_number).to eq(nil)
    end

    it '.valid_response?' do
      expect(Vote.valid_response?('1')).to eq(true)
      expect(Vote.valid_response?('2')).to eq(true)
      expect(Vote.valid_response?('3')).to eq(true)
      expect(Vote.valid_response?('4')).to eq(false)
      expect(Vote.valid_response?('one')).to eq(false)
      expect(Vote.valid_response?('food')).to eq(false)
      expect(Vote.valid_response?('11')).to eq(false)
    end
  end

  describe 'instance methods' do
  end
end

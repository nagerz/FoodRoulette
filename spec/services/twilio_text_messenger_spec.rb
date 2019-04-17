# frozen_string_literal: true

require 'rails_helper'

describe TwilioTextMessenger do
  it 'exists' do
    service = TwilioTextMessenger.new

    expect(service).to be_a(TwilioTextMessenger)
  end

  describe 'instance methods' do
    before :each do
      @service = TwilioTextMessenger.new
    end
    describe '#send_survey(data)' do
      it 'texts surveys to numbers according to the given data', :vcr do
        data = {
          sender: 'sender',
          phone_numbers: ['+15005550006'],
          event: 'event',
          date_time: 'date_time',
          restaurant_1: 'restaurant_1',
          restaurant_2: 'restaurant_2',
          restaurant_3: 'restaurant_3'
        }
        expect(@service.send_survey(data)).to eq(data[:phone_numbers])
      end
    end

    describe '#send_vote_receipt(_survey_id)' do
      it 'sends a message to users who have voted' do
      end
    end

    describe '#send_survey_result(survey_id)' do
      it 'sends the result of the survey to voters', :vcr do
        survey = create(:survey)
        num = create(:phone_number, digits: '+15005550006', survey: survey)
        sr = create(:survey_restaurant, survey: survey)
        create(:vote, phone_number: num, survey: survey, survey_restaurant: sr)

        result = @service.send_survey_result(survey.id)
        expect(result).to be_a(Array)
        expect(result[0]).to be_a(PhoneNumber)
      end
    end

    describe '#send_invalid_vote_response(phone_number)' do
      it 'sends a message if a voter gives an invalid response', :vcr do
        phone_number = '+15005550006'

        expect(@service.send_invalid_vote_response(phone_number))
          .to be_a(Twilio::REST::Api::V2010::AccountContext::MessageInstance)
      end
    end
  end
end

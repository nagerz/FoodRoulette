require 'rails_helper'

describe 'Surveys API' do
  it 'can return current votes for a survey' do
    survey = create(:survey)
    sr1 = create(:survey_restaurant, survey: survey)
    create(:survey_restaurant, survey: survey)
    create(:survey_restaurant, survey: survey)
    create(:vote, survey: survey, survey_restaurant: sr1)
    get "/api/v1/surveys/#{survey.id}"
    votes = JSON.parse(response.body)
    expect(response).to be_successful
    expect(votes["data"]["attributes"]["total_votes"]).to eq(1)
    expect(votes["data"]["attributes"]["restaurant_1_votes"]).to eq(1)
    expect(votes["data"]["attributes"]["restaurant_2_votes"]).to eq(0)
    expect(votes["data"]["attributes"]["restaurant_3_votes"]).to eq(0)
  end
end

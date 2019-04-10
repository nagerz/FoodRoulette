require 'rails_helper'

describe "As a visitor" do
  it "I cannot access any page on the site besides the login and survey pages" do
    visit '/'

    expect(current_path).to eq(login_path)

    visit '/login'

    expect(current_path).to eq(login_path)

    visit '/roulette'

    expect(current_path).to eq(login_path)

    visit '/roulettes'

    expect(current_path).to eq(login_path)

    visit '/directions'

    expect(current_path).to eq(login_path)

    visit '/vote/1'

    expect(current_path).to eq(login_path)

    visit '/profile'

    expect(current_path).to eq(login_path)

    visit '/about'

    expect(current_path).to eq(login_path)

  end

  it 'I can visit a survey results page but I cannot end the survey' do
    survey = create(:survey)

    visit survey_path(survey)

    expect(current_path).to eq(survey_path(survey))
    expect(page).to_not have_button('End Survey Now')
  end
end

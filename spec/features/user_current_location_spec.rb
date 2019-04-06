require 'rails_helper'

describe 'As a user' do
  it 'I can use my current location for a default random or group roulette', :vcr, type: :request do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit root_path

    cookies[:lat_long] = '39.733439499999996|-104.98441109999999'

    click_button 'Roulette Now'

    expect(current_path).to eq(roulette_path)
  end

  it 'I receieve an error message if I try to roulette without a current location', :vcr do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    click_button 'Roulette Now'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('You must set your location to do a search')
  end
end

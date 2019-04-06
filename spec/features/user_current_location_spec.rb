require 'rails_helper'

describe RouletteController, type: :controller do
  it 'the user\'s current location is used for a default random or group roulette', :vcr do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    cookies['lat_long'] = '39.733509399999996|-104.9844251'

    get 'show'

    expect(response.status).to eq(200)

    get 'index'

    expect(response.status).to eq(200)
  end

  # it 'I receieve an error message if I try to roulette without a current location', :vcr do
  #   user = create(:user)
  #   allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  #
  #   visit root_path
  #
  #   click_button 'Roulette Now'
  #
  #   expect(current_path).to eq(root_path)
  #   expect(page).to have_content('You must set your location to do a search')
  # end
end

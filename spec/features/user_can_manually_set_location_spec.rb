require 'rails_helper'

describe 'As a logged in user' do
  it 'I can set my location from the main page', :js, :vcr do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    set_location

    click_button 'Roulette Now'

    expect(current_path).to eq(roulette_path)
  end
end

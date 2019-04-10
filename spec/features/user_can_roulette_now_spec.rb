# frozen_string_literal: true

require 'rails_helper'

describe 'As a user' do
  it 'I can retrieve a single restaurant recommendation', :vcr do
    # As a visitor,
    # when I visit “/”,
    # and I click on “Roulette Now,”
    # I am redirected to “random#show” via “/random”
    # and I see the restaurant’s name, address, price range, cuisine type, star rating, open-now hours, and distance
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/'

    expect(current_path).to eq(root_path)
    set_location('Denver, CO')

    click_button 'Roulette Now'

    expect(current_path).to eq(roulette_path)

    expect(page).to have_css('.name')
    expect(page).to have_css('.address')
    expect(page).to have_css('.price_range')
    expect(page).to have_css('.cuisine')
    expect(page).to have_css('.rating')
    expect(page).to have_css('.distance')
  end
end

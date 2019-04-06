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

  it 'I receive an error when I try to do a search without a location set' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit root_path

    browser = Capybara.current_session.driver.browser
    browser.manage.delete_all_cookies


    click_button 'Roulette Now'

    expect(current_path).to eq(root_path)

    expect(page).to have_content('Please set a search location')
  end
end

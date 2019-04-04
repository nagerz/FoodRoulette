require 'rails_helper'

describe 'When a logged in user visits their profile page' do
  it 'they can log out of the app' do
    visit root_path

    click_button 'Connect to Google'

    expect(current_path).to eq(root_path)

    click_link 'Profile'

    expect(current_path).to eq(profile_path)

    click_button 'Log Out'

    expect(current_path).to eq(login_path)

    visit root_path

    expect(current_path).to eq(login_path)
  end
end

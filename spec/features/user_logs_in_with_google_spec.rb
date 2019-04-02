require 'rails_helper'

RSpec.feature 'user logs in' do
  it 'authenticating through Google' do

    visit '/'

    expect(current_path).to eq('/login')

    click_button 'Connect to Google'

    expect(current_path).to eq('/home')

    expect(page).to have_content('Welcome, Julia!')





    # If I am already logged in as a user, when I visit “/”, I see the home screen.
    # This story includes setup of the User model and database table. Please use your best judgment about which fields to store in the DB.
  end

end

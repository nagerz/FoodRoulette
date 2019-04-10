# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'user logs in' do
  it 'authenticating through Google' do
    visit '/'

    expect(current_path).to eq('/login')

    click_button 'Connect to Google'

    expect(current_path).to eq('/')

    expect(page).to have_content('Welcome, Julia!')
  end
end

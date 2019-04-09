require 'rails_helper'

RSpec.feature 'Home page' do
  context 'as a visitor' do
    it 'is redirected to login page' do
      visit root_path

      expect(current_path).to eq(login_path)
    end
  end

  context 'as a user' do
    it 'can visit home page' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path

      expect(current_path).to eq(root_path)

      #I see the app’s logo
      expect(page).to have_css(".home-header-logo-1")

      #I see a button for “Roulette Now” that says in small text “Ready to eat?” above it
      expect(page).to have_content('Ready to eat?')
      expect(page).to have_button('Roulette Now')

      #I see a button that says “Survey them!” with small text above it that says “Picky friends?”
      expect(page).to have_content('Picky Friends?')
      expect(page).to have_button('Survey them!')
    end
  end

end

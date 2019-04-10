# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Navigation bar' do
  context 'as a visitor' do
    context 'when I am redirected to the login page' do
      it 'I do not see a navigation bar' do
        visit root_path

        expect(current_path).to eq(login_path)

        expect(page).to_not have_link('Home')
        expect(page).to_not have_link('Profile')
        expect(page).to_not have_link('About')
      end
    end
  end

  context 'as a user' do
    before :each do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end

    context 'when I visit any page' do
      it 'I see a navigation bar' do
        visit root_path

        expect(current_path).to eq(root_path)

        expect(page).to have_link('Home')
        expect(page).to have_link('Profile')
        expect(page).to have_link('About')
      end

      it 'I can navigate to home' do
        visit root_path
        click_on 'Home'

        expect(current_path).to eq(root_path)
      end

      it 'I can navigate to my profile' do
        visit root_path

        click_on 'Profile'

        expect(current_path).to eq(profile_path)
      end

      it 'I can navigate to the about page' do
        visit root_path

        click_on 'About'

        expect(current_path).to eq(about_path)
      end
    end
  end
end

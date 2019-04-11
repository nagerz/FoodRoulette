# frozen_string_literal: true

require 'rails_helper'

describe 'as a user' do
  context 'when I visit my dashboard' do
    before :each do
      @user = create(:user)
      # rubocop:disable Metrics/LineLength
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      @restaurant1, @restaurant2, @restaurant3, @restaurant4, @restaurant5, @restaurant6 = create_list(:restaurant, 6)

      create(:visit, user: @user, restaurant: @restaurant1, longitude: 98.6, latitude: -5.6)
      create(:visit, user: @user, restaurant: @restaurant2, longitude: 98.6, latitude: -5.6)
      create(:visit, user: @user, restaurant: @restaurant3, longitude: 98.6, latitude: -5.6)
      create(:visit, user: @user, restaurant: @restaurant4, longitude: 98.6, latitude: -5.6)
      create(:visit, user: @user, restaurant: @restaurant5, longitude: 98.6, latitude: -5.6)
      create(:visit, user: @user, restaurant: @restaurant6, longitude: 98.6, latitude: -5.6)
      # rubocop:enable Metrics/LineLength
    end
    it 'shows me my name, address, and thumbnail' do
      visit '/profile'

      expect(page).to have_content(@user.first_name)
      expect(page).to have_content(@user.email)
      expect(page).to have_xpath("//img[@src='#{@user.thumbnail}']")
    end

    it 'also shows me the 5 most recent visits, with restaurant yelp links' do
      visit '/profile'
      expect(page).to have_css('#Visits')
      within '#Visits' do
        expect(page).to have_css('.visit', count: 5)
        within (all('.visit').first) do
          expect(page).to have_content(@restaurant1.name)
          click_on(@restaurant1.name)
        end
      end
      expect(page).to_not have_content(@restaurant6.name)
    end
  end
end

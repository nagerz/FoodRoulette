require 'rails_helper'

describe 'as a user' do
  context 'when I visit my dashboard' do
    before :each do
      @user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      @restaurant_1, @restaurant_2, @restaurant_3, @restaurant_4, @restaurant_5, @restaurant_6 = create_list(:restaurant, 6)

      visit_1 = create(:visit, user: @user, restaurant: @restaurant_1, longitude: 98.6, latitude: -5.6)
      visit_2 = create(:visit, user: @user, restaurant: @restaurant_2, longitude: 98.6, latitude: -5.6)
      visit_3 = create(:visit, user: @user, restaurant: @restaurant_3, longitude: 98.6, latitude: -5.6)
      visit_4 = create(:visit, user: @user, restaurant: @restaurant_4, longitude: 98.6, latitude: -5.6)
      visit_5 = create(:visit, user: @user, restaurant: @restaurant_5, longitude: 98.6, latitude: -5.6)
      visit_6 = create(:visit, user: @user, restaurant: @restaurant_6, longitude: 98.6, latitude: -5.6)
    end
    it 'shows me my name, address, and thumbnail' do
      visit '/profile'

      expect(page).to have_content(@user.first_name)
      expect(page).to have_content(@user.email)
      expect(page).to have_xpath("//img[@src='#{@user.thumbnail}']")
    end

    it 'also shows me the 5 most recent restaurants visited, linked to its yelp page' do

      visit '/profile'
      expect(page).to have_css('#Visits')
      within '#Visits' do
        expect(page).to have_css(".visit", count: 5)
        within (all('.visit').first) do

          expect(page).to have_content(@restaurant_1.name)
          click_on(@restaurant_1.name)

          expect(current_url).to eq(@restaurant_1.url)
        end
      end

      expect(page).to_not have_content(@restaurant_6.name)
    end
  end
end

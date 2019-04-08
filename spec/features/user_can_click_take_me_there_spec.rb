require 'rails_helper'

 describe 'As a user' do
  describe 'when I click \'Take Me There!\' from the roulette show page' do
    it 'A visit is created linking me to that restaurant and I am taken to a Google Maps directions page', :vcr do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/'

      set_location('1331 17th St LL100, Denver, CO 80202')

      click_button 'Roulette Now'

      expect(current_path).to eq(roulette_path)

      expect(User.first.visits.count).to eq(0)
      expect(User.first.restaurants.count).to eq(0)

      click_button 'Take Me There!'
    
      expect(current_url[0..30]).to eq('https://www.google.com/maps/dir')

      expect(User.first.visits.count).to eq(1)
      expect(User.first.restaurants.count).to eq(1)
    end
  end
end

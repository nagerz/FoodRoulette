# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RestaurantFacade do
  before :each do
    @facade = RestaurantFacade.new
  end

  it 'exists' do
    expect(@facade).to be_a(RestaurantFacade)
  end

  describe '.recommendation', :vcr do
    describe 'rouletted restaurant exists in the database' do
      it 'creates a recommendation' do
        existing_restaurant = create(:restaurant, yelp_id: 'test123')

        url = 'https://api.yelp.com/v3/businesses/search?categories=restaurants&limit=50&location=80202&open_now=true&price=1,2&radius=8000'
        filename = 'random_roulette_response.json'
        stub_get_json(url, filename)

        expect(Restaurant.all.count).to eq(1)

        new_recommendation = @facade.recommendation('80202')

        expect(Restaurant.all.count).to eq(1)
        expect(new_recommendation).to be_a(Recommendation)
        expect(new_recommendation.restaurant_id).to eq('test123')
      end
    end

    describe 'rouletted restaurant does not exist in the database and can be saved' do
      it 'creates a recommendation' do
        url = 'https://api.yelp.com/v3/businesses/search?categories=restaurants&limit=50&location=80202&open_now=true&price=1,2&radius=8000'
        filename = 'random_roulette_response.json'
        stub_get_json(url, filename)

        expect(Restaurant.all.count).to eq(0)

        new_recommendation = @facade.recommendation('80202')

        expect(Restaurant.all.count).to eq(1)
        expect(Restaurant.first.yelp_id).to eq('test123')
        expect(new_recommendation).to be_a(Recommendation)
        expect(new_recommendation.restaurant_id).to eq('test123')
      end
    end

    describe 'rouletted restaurant does not exist in the database and can not be saved' do
      it 'creates a recommendation' do
        url = 'https://api.yelp.com/v3/businesses/search?categories=restaurants&limit=50&location=80202&open_now=true&price=1,2&radius=8000'
        filename = 'random_roulette_response_with_bad.json'
        stub_get_json(url, filename)

        expect(Restaurant.all.count).to eq(0)

        new_recommendation = @facade.recommendation('80202')

        expect(Restaurant.all.count).to eq(1)
        expect(Restaurant.first.yelp_id).to eq('test123')
        expect(new_recommendation).to be_a(Recommendation)
        expect(new_recommendation.restaurant_id).to eq('test123')
      end
    end
  end
end

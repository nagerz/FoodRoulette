require 'rails_helper'

describe "Yelp Service", type: :service do
  describe "returns results limited to" do
    before :each do
      @response ||= YelpService.new.restaurants("80202")
    end

    it "within 8000 meters / ~5 miles", :vcr do
      @response.each do |restaurant_data|
        expect(restaurant_data[:distance]).to be < 8000
      end
    end

    it "restaurants open now", :vcr do
      @response.each do |restaurant_data|
        expect(restaurant_data[:is_closed]).to eq(false)
      end
    end

    it "price of 2 or under", :vcr do
      @response.each do |restaurant_data|
        expect(restaurant_data[:price]).to eq("$").or eq("$$")
      end
    end

  end
end

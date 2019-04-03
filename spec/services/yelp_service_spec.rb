require 'rails_helper'

describe "Yelp Service", type: :service do
  describe "returns results limited to" do
    before :each do
      @response ||= YelpService.new.get_random_restaurant("80202")
    end

    #Chris do you have a way to test distance easily?
    xit "within 8000 meters / ~5 miles" do
      @response.each do |restaurant_data|
        expect(restaurant_data[])
      end
    end

    it "restaurants open now" do
      @response.each do |restaurant_data|
        binding.pry
        expect(restaurant_data[:is_closed]).to eq(:false)
      end
    end

    it "price of 2 or under" do
      @response.each do |restaurant_data|
        expect(restaurant_data[:price]).to eq("$" || "$$")
      end
    end

  end
end

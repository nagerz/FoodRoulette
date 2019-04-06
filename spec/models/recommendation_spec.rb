require 'rails_helper'

describe Recommendation, type: :model do
  before :each do
    @restaurant_data = {
        "id": "test_id",
        "alias": "snooze-an-a-m-eatery-denver-12",
        "name": "Snooze, An A.M. Eatery",
        "is_closed": false,
        "url": "https://www.yelp.com/biz/snooze-an-a-m-eatery-denver-12?adjust_creative=kstLs0KgHxdskM-IpaNJoA&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=kstLs0KgHxdskM-IpaNJoA",
        "review_count": 3799,
        "categories": [
            {
                "alias": "breakfast_brunch",
                "title": "Breakfast & Brunch"
            },
            {
                "alias": "sandwiches",
                "title": "Sandwiches"
            },
            {
                "alias": "coffee",
                "title": "Coffee & Tea"
            }
        ],
        "rating": 4.5,
        "coordinates": {
            "latitude": 39.755459608447,
            "longitude": -104.988913938884
        },
        "price": "$$",
        "location": {
            "address1": "2262 Larimer St",
            "address2": "",
            "address3": "",
            "city": "Denver",
            "zip_code": "80205",
            "country": "US",
            "state": "CO",
            "display_address": [
                "2262 Larimer St",
                "Denver, CO 80205"
            ]
        },
        "phone": "+13032970700",
        "display_phone": "(303) 297-0700",
        "distance": 963.6331565339298
    }

    @restaurant = create(:restaurant,
                          yelp_id: "test_id",
                          name: "Snooze, An A.M. Eatery",
                          latitude: 39.755459608447,
                          longitude: -104.988913938884,
                          price: "$$",
                          rating: 4.5,
                          category_1: "Breakfast & Brunch"
                        )
  end

  it "exists" do
    rec = Recommendation.new(@restaurant_data, @restaurant)

    expect(rec).to be_a(Recommendation)
  end

  it "has attributes" do
    rec = Recommendation.new(@restaurant_data, @restaurant)

    expect(rec.name).to eq("Snooze, An A.M. Eatery")
    expect(rec.address).to eq("2262 Larimer St  Denver, CO 80205")
    expect(rec.price_range).to eq("$$")
    expect(rec.cuisine).to eq("Breakfast & Brunch")
    expect(rec.rating).to eq(4.5)
    # expect(rec.hours).to eq(rec)
    expect(rec.distance).to eq(0.6)
  end
end

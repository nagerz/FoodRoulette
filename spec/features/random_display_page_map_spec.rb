# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a user, when I visit the restaurant display page' do
  it 'I see a map showing the location of the selected restaurant' do
    yelp_api = {
                "location":
                {
                  "address1": "800 N Point St",
                  "address2": "",
                  "address3": "",
                  "city": "San Francisco",
                  "zip_code": "94109",
                  "country": "US",
                  "state": "CA",
                  "display_address": [
                    "800 N Point St",
                    "San Francisco, CA 94109"
                  ],
                  "cross_streets": ""
                },
                "coordinates": {
                                "latitude": 37.80587,
                                "longitude": -122.42058
                              }
                }

  	visit '/random'

    #test map shows?
  	expect(page).to have_content("800 N Point St")
  end
end

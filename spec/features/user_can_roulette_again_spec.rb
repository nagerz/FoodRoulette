# frozen_string_literal: true

require 'rails_helper'

describe 'As a user' do
  # Need to add functionality to not repeat recommendation
  it 'I can roulette again', :vcr do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    url = 'https://api.yelp.com/v3/businesses/search?categories=restaurants&limit=50&location=80202&open_now=true&price=1,2&radius=8000'
    filename = 'roulette_again_response.json'
    stub_get_json(url, filename)

    visit '/'

    set_location('Denver, CO')
    click_button 'Roulette Now'

    first_parsed_html = Nokogiri::HTML.parse(page.html)

    restaurant_name = first_parsed_html.css('.name')[0].text
    restaurant_address = first_parsed_html.css('.address')[0].text

    click_button 'Roulette Again'

    second_parsed_html = Nokogiri::HTML.parse(page.html)

    restaurant_name_2 = second_parsed_html.css('.name')[0].text
    restaurant_address_2 = second_parsed_html.css('.address')[0].text

    expect(second_parsed_html.css('.name')[0].text).to_not eq(restaurant_name)
    expect(second_parsed_html.css('.address')[0].text).to_not eq(restaurant_address)

    click_button 'Roulette Again'

    third_parsed_html = Nokogiri::HTML.parse(page.html)

    expect(third_parsed_html.css('.name')[0].text).to_not eq(restaurant_name || restaurant_name_2)
    expect(third_parsed_html.css('.address')[0].text).to_not eq(restaurant_address || restaurant_address_2)
  end
end

# frozen_string_literal: true

require 'rails_helper'

describe 'As a user' do
  # Need to add functionality to not repeat recommendation
  it 'I can roulette again', :vcr do
    user = create(:user)
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(user)

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

    restaurant_name2 = second_parsed_html.css('.name')[0].text
    restaurant_address2 = second_parsed_html.css('.address')[0].text
    restaurant_2_name = second_parsed_html.css('.name')[0].text
    restaurant_2_address = second_parsed_html.css('.address')[0].text
    expect(restaurant_2_name).to_not eq(restaurant_name)
    expect(restaurant_2_address).to_not eq(restaurant_address)

    click_button 'Roulette Again'

    third_parsed_html = Nokogiri::HTML.parse(page.html)

    restaurant_3_name = third_parsed_html.css('.name')[0].text
    restaurant_3_address = third_parsed_html.css('.address')[0].text
    expect(restaurant_3_name).to_not eq(restaurant_name || restaurant_name2)
    expect(restaurant_3_address)
      .to_not eq(restaurant_address || restaurant_address2)
  end
end

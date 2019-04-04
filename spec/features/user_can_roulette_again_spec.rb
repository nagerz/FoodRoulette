require 'rails_helper'

describe 'As a user' do
  it 'I can roulette again', :vcr do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/'

    click_button 'Roulette Now'

    first_parsed_html = Nokogiri::HTML.parse(page.html)

    restaurant_name = first_parsed_html.css(".name")[0].text
    restaurant_address = first_parsed_html.css(".address")[0].text

    click_button 'Roulette Again'

    second_parsed_html = Nokogiri::HTML.parse(page.html)

    expect(second_parsed_html.css(".name")[0].text).to_not eq(restaurant_name)
    expect(second_parsed_html.css(".address")[0].text).to_not eq(restaurant_address)
  
  end
end

require 'rails_helper'

describe "As a visitor" do
  context "I cannot access any page on the site besides the login page" do
    visit '/'

    expect(current_path).to eq(login_path)

    visit '/login'

    expect(current_path).to eq(login_path)

    visit '/roulette'

    expect(current_path).to eq(login_path)

    visit '/roulettes'

    expect(current_path).to eq(login_path)

    visit '/directions'

    expect(current_path).to eq(login_path)

    visit '/surveys/1'

    expect(current_path).to eq(login_path)

    visit '/vote/1'

    expect(current_path).to eq(login_path)

    visit '/profile'

    expect(current_path).to eq(login_path)

    visit '/about'

    expect(current_path).to eq(login_path)

  end
end

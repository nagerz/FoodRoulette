require 'rails_helper'

describe RouletteController, type: :controller do
  it 'the user\'s current location is used for a default random or group roulette', :vcr do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    cookies['lat_long'] = '39.733509399999996|-104.9844251'

    get 'show'

    expect(response.status).to eq(200)

    get 'index'

    expect(response.status).to eq(200)
  end

  it 'the user\'s manal location can be used for a default random or group roulette', :vcr do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    cookies['manual_location'] = 'Denver, CO'

    get 'show'

    expect(response.status).to eq(200)

    get 'index'

    expect(response.status).to eq(200)
  end
end

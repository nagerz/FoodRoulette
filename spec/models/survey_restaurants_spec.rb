require 'rails_helper'

RSpec.describe SurveyRestaurant, type: :model do
  describe 'relationships' do
    it { should belong_to(:survey) }
    it { should belong_to(:restaurant) }
  end
end

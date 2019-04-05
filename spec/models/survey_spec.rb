require 'rails_helper'

RSpec.describe Survey, type: :model do
  describe 'relationships' do
    it { should belong_to(:user) }
    it { should have_many(:survey_restaurants) }
    it { should have_many(:restaurants).through(:survey_restaurants) }
  end
end

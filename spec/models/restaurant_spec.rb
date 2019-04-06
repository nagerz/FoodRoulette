require 'rails_helper'

describe Restaurant, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:yelp_id) }
    it { should validate_uniqueness_of(:yelp_id) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:latitude) }
    it { should validate_presence_of(:longitude) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:rating) }
    it { should validate_presence_of(:category_1) }
  end

  describe 'relationships' do
    it { should have_many(:survey_restaurants) }
    it { should have_many(:visits) }
    it { should have_many(:users).through(:visits) }
  end
end

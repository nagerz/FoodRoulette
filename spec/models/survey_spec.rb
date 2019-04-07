require 'rails_helper'

RSpec.describe Survey, type: :model do
  describe 'relationships' do
    it { should belong_to(:user) }
    it { should have_many(:survey_restaurants) }
    it { should have_many(:restaurants).through(:survey_restaurants) }
  end

  describe "instance methods" do
    it "#unique_vote?" do
    end

    it "#active?" do
    end

    it "#find_survey_restaurant" do
    end
  end

end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Visit, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:longitude) }
    it { should validate_presence_of(:latitude) }
  end

  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:restaurant) }
  end
end

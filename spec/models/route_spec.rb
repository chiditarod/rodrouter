require 'rails_helper'

RSpec.describe Route, type: :model do

  describe 'validations' do
    context 'with valid attributes' do
      let(:route) { FactoryBot.build :full_route }

      it 'is valid' do
        expect(route).to be_valid
      end
    end

    context 'when there are too many legs' do
      let(:route) { FactoryBot.build :full_route }

      it 'is invalid with appropriate message' do
        route.leg_ids << FactoryBot.create(:leg).id
        expect(route).to be_invalid
      end
    end
  end
end

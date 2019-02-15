require 'rails_helper'

RSpec.describe Leg, type: :model do
  let(:test_mode) { {min: 0.3, max: 0.5} }

  #describe '#create_from_locations' do
    #before do
      #3.times { FactoryBot.create :location }
    #end

    #it 'creates all possible legs between each location' do
      #expect(Leg.all).to be_empty
      #Leg.create_from_locations(Location.all, test_mode)
      #expect(Leg.where(start: Location.first).size).to eq(2)
      #expect(Leg.all.size).to eq(6)
    #end
  #end

  describe '.fetch_distance' do
    #context 'when in test_mode' do
      #let(:start) { FactoryBot.create :location }
      #let(:finish) { FactoryBot.create :location }

      #it 'returns a value between min and max' do
        #leg = Leg.create(start: start, finish: finish, test_mode: test_mode)
        #expect(leg.distance < 0.5).to be true
        #expect(leg.distance > 0.3).to be true
      #end
    #end

    it 'fetches distance from Google Maps API'
  end

  describe '.save' do
    let(:start) { FactoryBot.create :location }
    let(:finish) { FactoryBot.create :location }

    it 'creates a mirror leg' do
      expect do
        Leg.create(start: start, finish: finish, distance: 1.0)
      end.to change(Leg, :count).by(2)

      expect(Leg.where(start: start, finish: finish).size).to eq(1)
      expect(Leg.where(start: finish, finish: start).size).to eq(1)
    end
  end

  describe 'scopes' do

    describe '#valid_for_race' do

      shared_examples "empty" do
        it "returns empty" do
          expect(Leg.valid_for_race(race)).to be_empty
        end
      end

      context 'when race has no locations' do
        let(:race) { FactoryBot.create :race }
        include_examples "empty"
      end

      context 'when race has locations' do
        let(:race) { FactoryBot.create :race, :with_locations }

        context 'no legs exist' do
          include_examples "empty"
        end

        context 'leg exists with unrelated locations' do
          let!(:leg) { FactoryBot.create :leg }
          include_examples "empty"
        end

        context 'leg exists and start or finish is in race locations but not both' do
          let!(:leg) { FactoryBot.create :leg, start: race.locations.first }
          include_examples "empty"
        end

        context 'leg exists and both start and finish are in race locations' do
          let!(:leg) { FactoryBot.create :leg, start: race.locations.first, finish: race.locations.last }
          it 'includes the leg and its mirror' do
            mirror = Leg.where(start: leg.finish, finish: leg.start).first
            expect(Leg.valid_for_race(race)).to eq([leg, mirror])
          end
        end
      end
    end
  end
end

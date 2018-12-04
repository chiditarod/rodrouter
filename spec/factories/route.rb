FactoryBot.define do
  factory :route do
    race

    factory :full_route do
      after(:build) do |route, evaluator|
        (route.race.num_stops + 2).times do
          route.leg_ids << FactoryBot.create(:leg).id
        end
      end
    end
  end
end

FactoryBot.define do
  factory :race do
    sequence(:name) { |n| "Race #{n}" }
    num_stops { 3 }
    max_teams { 5 }
    people_per_team { 5 }
    min_total_distance { 3.5 }
    max_total_distance { 5.5 }
    min_leg_distance { 0.8 }
    max_leg_distance { 1.2 }
    association :start, factory: :location
    association :finish, factory: :location

    trait :with_locations do
      transient do
        count { num_stops + 2 } # adds the start and finish
      end

      after(:build) do |race, evaluator|
        evaluator.count.times do |n|
          race.location_id_pool << FactoryBot.create(:location).id
        end
      end
    end
  end
end

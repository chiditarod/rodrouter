FactoryBot.define do
  factory :race do
    sequence(:name) { |n| "Race #{n}" }
    num_checkpoints 5
    max_teams 5
    people_per_team 5
    min_total_distance 3.5
    max_total_distance 5.5
    min_leg_distance 0.8
    max_leg_distance 1.2
    association :start, factory: :location
    association :finish, factory: :location
  end
end

FactoryBot.define do
  factory :location do
    sequence(:name) { |n| "Location #{n}" }
    max_capacity { 150 }
    ideal_capacity { 100 }
  end
end

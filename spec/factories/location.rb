FactoryBot.define do
  factory :location do
    name { Faker::Nation.unique.capital_city }
    max_capacity { 150 }
    ideal_capacity { 100 }
  end
end

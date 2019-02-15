FactoryBot.define do
  factory :location do
    name { Faker::Nation.unique.capital_city }
    street_address { Faker::Address.unique.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Random.rand(99999) }
    max_capacity { 150 }
    ideal_capacity { 100 }
  end
end

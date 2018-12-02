FactoryBot.define do
  factory :route do
    race

    after(:build) do |route, evaluator|
      route.legs_array = [route.race.start.id, route.race.finish.id]
      route.save
    end
  end
end

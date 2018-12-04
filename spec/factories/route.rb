FactoryBot.define do
  factory :route do
    race

    #after(:create) do |route, evaluator|
      #route.race.locations = route.legs.map(&:start).concat(route.legs.map(&:finish)).uniq
    #end

    factory :sequential_route do
      after(:create) do |route, evaluator|
        # start
        route.legs << FactoryBot.create(:leg, start: route.race.start)
        # middle legs
        (route.race.num_stops - 1).times do
          route.legs << FactoryBot.create(:leg, start: route.legs.last.finish)
        end
        # finish
        route.legs << FactoryBot.create(:leg, start: route.legs.last.finish, finish: route.race.finish)

        # add all of the locations created above into the location pool for the race
        route.race.locations = route.legs.map(&:start).concat(route.legs.map(&:finish)).uniq
        route.save
      end
    end
  end
end

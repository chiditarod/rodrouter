class RouteGenerator


  def self.run

    route = Route.new(race)

    route.race.availble_locations.inject([]) do |memo, location|
      memo.concat(find_routes(race, location))
    end

    private

    def find_routes(race, location)
      

    end
  end
end

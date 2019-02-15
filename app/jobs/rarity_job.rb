class RarityJob < ApplicationJob

  # given a list of ids of completed routes,
  # look at the rarity of each location in each position across all routes.
  # the less frequently a route appears in a position, the more valuable the route is
  # for each route
  #   for each position
  #     frequencies[location.name] += 1
  def perform(route_ids)
    # TODO: ensure route ids all have the same race
    # ensure routes are all complete
    routes = Route.where(id: route_ids)
    num_stops = routes.first.race.num_stops

    freqs = {}
    routes.each do |route|
      legs = route.legs.to_a
      legs.pop # throw away the last leg since we eval leg finishes only
      legs.each_with_index do |leg, i|
        freqs[leg.finish.id] ||= Array.new(num_stops, 0)
        freqs[leg.finish.id][i] += 1
      end
    end

    output freqs

    rarist = {}

    freqs.each do |id, data|
      min = data.reject{|d| d == 0}.min
      max = data.max
      data.each_with_index do |val, i|
        if val == min && val != max
          rarist[id] ||= []
          rarist[id] << i
        end
      end
    end

    ap rarist

    rare_routes = []
    rarist.each do |id, rare_stops|
      rare_stops.each do |leg|
        r = routes.select { |r| r.legs[leg].finish.id == id }
        rare_routes.append << r
      end
    end

    puts rare_routes.uniq
  end

  private

  def output(freqs)
    c = freqs.first.size
    print 'Location'.ljust(25)
    (freqs.first[1].size).times do |i|
      print "Stop #{(i + 1)}".ljust(10)
    end
    puts

    freqs.each do |id, data|
      print "#{Location.find(id).name} (#{id})".ljust(25)
      data.each do |d|
        print d.to_s.ljust(10)
      end
      puts
    end
    nil
  end
end

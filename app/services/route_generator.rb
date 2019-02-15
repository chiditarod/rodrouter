class RouteGenerator

  def self.call(race, route=nil)
    route ||= Route.create(race: race)

    if route.complete?
      route.save!
      puts "COMPLETE: #{route}"
      return
    end

    puts "PROCESSING: #{route}"

    pool = case
           when route.legs.empty?
             Leg.valid_for_race(race).where(start: race.start)
           when route.legs_needed == 1
             Leg.valid_for_race(race).
               where(start: route.legs.last.finish).
               where(finish: route.race.finish)
           else
             Leg.valid_for_race(race).
               where(start: route.legs.last.finish).
               where("finish_id NOT IN (?)", route.legs.map(&:finish_id)).
               where("finish_id != ?", route.race.start_id)
           end

    pool.each do |leg|
      print "  TRYING: #{leg} ... "
      candidate = Route.create(race: race)
      candidate.legs = route.legs
      candidate.legs << leg

      if candidate.save
        puts "VALID"
        call(race, candidate)
      else
        puts "INVALID"
        puts candidate.errors.messages.map{|m| "    #{m[1].join('\n')}" }
        #candidate.destroy
      end
    end

    nil
  end
end

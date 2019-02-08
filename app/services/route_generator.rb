class RouteGenerator

  def self.call(race, route=nil)
    route ||= Route.create(race: race)

    #puts "START: #{route}"

    if route.complete?
      route.save!
      puts "COMPLETE: #{route}"
      return
    end

    # get all potential legs coming up next
    # if legs = 0, then this is brand new, and only select valid starting legs
    # if legs > 0, only select legs that:
    #   don't use a start_id already in use
    #   don't use a finish_id already in use unless we have 1 more stop
    #   don't use a finish_id already in use
    pool = case
           when route.legs.size == 0
             Leg.valid_for_race(race).where(start: race.start)
           when route.legs_needed == 1
             Leg.valid_for_race(race).
               where(start: route.legs.last.finish).
               #where("start_id NOT IN (?)", route.legs.map(&:start_id)).
               where(finish: route.race.finish)
           else
             Leg.valid_for_race(race).
               where(start: route.legs.last.finish).
               where("finish_id NOT IN (?)", route.legs.map(&:finish_id)).
               where("finish_id != ?", route.race.start_id)
           end

    puts "POOL for: #{route}:"
    puts pool&.map{|a| "\t#{a}" }

    pool.each do |leg|
      candidate = Route.create(race: race)
      candidate.legs = route.legs
      candidate.legs << leg

      if candidate.save
        call(race, candidate)
      else
        puts "INVALID: #{route}"
        puts candidate.errors.messages.map{|m| "\t#{m}" }
      end
    end
  end
end

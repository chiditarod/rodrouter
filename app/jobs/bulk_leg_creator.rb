class BulkLegCreator < ApplicationJob

  def perform(location_ids)
    location_ids.each_with_index do |cur, i|
      ids_without_current = location_ids.reject.with_index{|v, j| j == i }
      fetch_distances_for_origin(cur, ids_without_current)
    end
  end

  private

  def fetch_distances_for_origin(origin_id, destination_ids)
    preexisting_legs = Leg.where(start_id: origin_id).map(&:finish_id)
    destinations = Location.where(id: destination_ids).
      reject { |l| preexisting_legs.include?(l.id) }

    return if destinations.empty?

    client = GoogleApiClient.new.client
    origin = Location.find(origin_id)

    ap destinations.map(&:full_address)
    ap [origin.full_address]

    resp = client.distance_matrix([origin.full_address],
                                  destinations.map(&:full_address),
                                  mode: 'walking',
                                  language: 'en-US',
                                  avoid: 'tolls',
                                  units: 'imperial')

    # we pass a single origin to return a single row w/ multiple elements
    # an optimization (to save $$$ via less API calls) is to pass multiple
    # origins and parse the multiple rows/elements
    resp.dig(:rows).first.dig(:elements).each_with_index do |elem, i|
      Leg.create(start: origin,
                 finish: destinations[i],
                 distance: elem.dig(:distance, :value))
    end
  end
end

# More complex setup
class FetchLegDistances < ApplicationJob

  MAX_IDS_PER_API_CALL = 25

  def perform(location_pool_ids)

    if location_pool_ids.size > MAX_IDS_PER_API_CALL
      puts "Splitting location_pool_ids"
      location_pool_ids.each_slice(MAX_IDS_PER_API_CALL).to_a.each do |chunk|
        FetchLegDistances.perform_later(chunk)
      end
    end

    # get all of the addresses for every location
    pool = location_pool_ids.map { |id| Location.find(id) }.map(&:full_address)

    client = GoogleApiClient.new
    matrix = client.client.distance_matrix(origins, destinations,
                                     mode: 'walking',
                                     language: 'en-US',
                                     avoid: 'tolls',
                                     units: 'imperial')
  end


end

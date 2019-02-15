locations = [
  ['Cobra Lounge', '235 N Ashland Ave', 'Chicago', 'IL', 60607, 'USA', 400, 250],
  ['Output', '1758 W Grand Ave', 'Chicago', 'IL', 60622, 'USA', 200, 150],
  ['Five Star Bar', '1424 W Chicago Ave', 'Chicago', 'IL', 60642, 'USA', 300, 200],
  ['Phyllis Musical Inn', '1800 W Division St', 'Chicago', 'IL', 60622, 'USA', 200, 150],
  ['Roots Pizza', '1924 W Chicago Ave', 'Chicago', 'IL', 60622, 'USA', 400, 250],
  ['Mahoneys', '551 N Ogden Ave', 'Chicago', 'IL', 60642, 'USA', 800, 600]
]

location.each do |loc|
  Location.create(name: loc[0],
                  street_address: loc[1],
                  city: loc[2],
                  state: loc[3],
                  zip: loc[4],
                  country: loc[5],
                  max_capacity: loc[6],
                  ideal_capacity: loc[7])
end

cobra = Location.find_by(name: "Cobra Lounge")

race = Race.create(name: "CHIditarod XIV",
                   start: cobra,
                   finish: cobra,
                   locations: Location.all,
                   num_stops: 5,
                   max_teams: 150,
                   people_per_team: 5,
                   min_total_distance: 4.2,
                   max_total_distance: 5.3,
                   min_leg_distance: 0.2,
                   max_leg_distance: 1.2,
                   distance_unit: "mi")

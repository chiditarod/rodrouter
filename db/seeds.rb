# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
seeds = [
  ['Cobra Lounge', '235 N Ashland Ave', 'Chicago', 'IL', 60607, 'USA', 400, 250],
  ['Output', '1758 W Grand Ave', 'Chicago', 'IL', 60622, 'USA', 200, 150],
  ['Five Star Bar', '1424 W Chicago Ave', 'Chicago', 'IL', 60642, 'USA', 300, 200],
  ['Phyllis Musical Inn', '1800 W Division St', 'Chicago', 'IL', 60622, 'USA', 200, 150],
  ['Roots Pizza', '1924 W Chicago Ave', 'Chicago', 'IL', 60622, 'USA', 400, 250],
  ['Mahoneys', '551 N Ogden Ave', 'Chicago', 'IL', 60642, 'USA', 800, 600]
]

seeds.each do |seed|
  Location.create(name: seed[0],
                  street_address: seed[1],
                  city: seed[2],
                  state: seed[3],
                  zip: seed[4],
                  country: seed[5],
                  max_capacity: seed[6],
                  ideal_capacity: seed[7])
end

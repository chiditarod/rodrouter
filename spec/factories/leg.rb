FactoryBot.define do
  factory :leg do
    association :start, factory: :location
    association :finish, factory: :location
    distance 1.0
  end
end

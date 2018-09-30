FactoryBot.define do
  factory :task do
    name { Faker::StarWars.planet }
  end
end
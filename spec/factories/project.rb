FactoryBot.define do
  factory :project do
    name { Faker::StarWars.planet }
  end
end
FactoryBot.define do
  factory :task do
    name { Faker::StarWars.planet }
    text { Faker::StarWars.quote("leia_organa") }
  end
end
FactoryBot.define do
  factory :comment do
    text { Faker::StarWars.quote("leia_organa") }
    file { Faker::StarWars.planet }
  end
end
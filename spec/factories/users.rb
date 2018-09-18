FactoryBot.define do
  factory :user do
    username { Faker::StarWars.character }
    uid {'egewg5hr'}
    password { 'password1' }
    password_confirmation { |user| user.password }
  end
end
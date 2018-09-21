FactoryBot.define do
  factory :user do
    email { 'test@gmail.com' }
    uid {'egewg5hr'}
    password { '12345678' }
    password_confirmation { '12345678' }
  end
end
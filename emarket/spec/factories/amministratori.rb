FactoryBot.define do
    factory :amministratore do
      email { Faker::Internet.email }
      password { "password" }
    end
  end
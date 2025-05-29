FactoryBot.define do
    factory :acquirente do
      nome { "Mario" }
      cognome { "Rossi" }
      email { Faker::Internet.email }
      password { "password" }
    end
  end
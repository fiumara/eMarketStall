FactoryBot.define do
  factory :negozio do
    nome_negozio { "Negozio Test" }
    email { Faker::Internet.email }
    
    association :acquirente
  end
end

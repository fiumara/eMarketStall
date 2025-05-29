FactoryBot.define do
    factory :chat_room do
      nome { "Chat Test" }
      association :mittente, factory: :acquirente
      association :destinatario, factory: :negozio
    end
  end
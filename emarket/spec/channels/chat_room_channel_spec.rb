# spec/channels/chat_room_channel_spec.rb
require 'rails_helper'

RSpec.describe ChatRoomChannel, type: :channel do
  let(:acquirente) { create(:acquirente) }
  let(:destinatario) { create(:negozio) }
  let(:chat_room) { create(:chat_room, mittente: acquirente, destinatario: destinatario) }

  before do
    stub_connection current_user: acquirente
  end

  it "sottoscrive al canale correttamente" do
    subscribe(chat_id: chat_room.id)

    expect(subscription).to be_confirmed
    expect(subscription).to have_stream_for(chat_room)
  end

  describe "#speak" do
    it "crea un messaggio e lo trasmette in broadcast" do
      subscribe(chat_id: chat_room.id)

      expect {
        perform :speak, { message: "Ciao dal test!" }
      }.to change { chat_room.messaggi.count }.by(1)

      messaggio = chat_room.messaggi.last
      expect(transmissions.last["message_html"]).to include(messaggio.contenuto)
    end
  end
end

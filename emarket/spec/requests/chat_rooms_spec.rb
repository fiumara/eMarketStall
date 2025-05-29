require 'rails_helper'

RSpec.describe ChatRoomsController, type: :request do
  let(:acquirente) { create(:acquirente) }
  let(:negozio) { create(:negozio) }
  let(:admin) { create(:amministratore) }

  before do
    # Simula un login
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(acquirente)
  end

  describe "GET /chat_rooms" do
    it "mostra le chat disponibili" do
      get chat_rooms_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /chat_rooms/new" do
    it "apre il form per una nuova chat" do
      get new_chat_room_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /chat_rooms" do
    it "crea una nuova chat" do
      post chat_rooms_path, params: {
        chat_room: {
          nome: "Nuova chat",
          destinatario_id: negozio.id,
          destinatario_type: "Negozio"
        }
      }

      expect(response).to redirect_to(ChatRoom.last)
      expect(ChatRoom.last.mittente).to eq(acquirente)
    end
  end

  describe "GET /chat_rooms/:id" do
    let(:chat_room) { create(:chat_room, mittente: acquirente, destinatario: negozio) }

    it "mostra i messaggi della chat" do
      get chat_room_path(chat_room)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /chat_rooms/:id/messages" do
    let(:chat_room) { create(:chat_room, mittente: acquirente, destinatario: negozio) }

    it "crea un nuovo messaggio" do
      post "/chat_rooms/#{chat_room.id}/messages", params: {
        messaggio: { contenuto: "Ciao" }
      }

      expect(response).to redirect_to(chat_room)
      chat_room.reload
      expect(chat_room.messaggi.last.contenuto).to eq("Ciao")
    end
  end

  describe "DELETE /chat_rooms/:id" do
    let!(:chat_room) { create(:chat_room, mittente: acquirente, destinatario: negozio) }

    it "nasconde la chat all'utente corrente" do
      delete chat_room_path(chat_room)
      expect(response).to redirect_to(chat_rooms_path)
      expect(chat_room.reload.mittente_visible).to be_falsey
    end
  end
end

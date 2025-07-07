import consumer from "./consumer"

const chatRoomElement = document.getElementById('chat-room');
if (!chatRoomElement) {
  console.warn("Elemento 'chat-room' non trovato");
  return;
}

const chatId = chatRoomElement.dataset.chatId;


consumer.subscriptions.create({ channel: "MessageChannel", chat_id: chatId }, {
  connected() {
  },

  disconnected() {
    console.log("Connessione persa. Tentativo di riconnessione...");
  },
  

  received(data) {
    const messagesContainer = document.getElementById('messages');
    if (!messagesContainer) {
      console.warn("Container dei messaggi non trovato");
      return;
    }
    messagesContainer.innerHTML += data.message;
  },
  

  speak(message) {
    return this.perform('speak', { message: message });
  }
});

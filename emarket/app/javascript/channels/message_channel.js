import consumer from "./consumer"

const chatId = document.getElementById('chat-room').dataset.chatId

consumer.subscriptions.create({ channel: "MessageChannel", chat_id: chatId }, {
  connected() {
    // Chiamato quando la connessione al canale è stabilita
  },

  disconnected() {
    // Chiamato quando la connessione al canale è interrotta
  },

  received(data) {
    // Ricevi i dati dal server e aggiorna il DOM (visualizzazione del nuovo messaggio)
    const messagesContainer = document.getElementById('messages')
    messagesContainer.innerHTML += data.message
  },

  speak(message) {
    // Invia il messaggio al canale
    return this.perform('speak', { message: message });
  }
});

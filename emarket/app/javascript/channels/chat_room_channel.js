import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {
  const chatRoomElement = document.getElementById('messages');
  if (chatRoomElement) {
    const chatRoomId = chatRoomElement.getAttribute('data-chat-room-id');
    console.log("Connesso al canale della chat room ID:", chatRoomId);

    consumer.subscriptions.create({ channel: "ChatRoomChannel", chat_room_id: chatRoomId }, {
      received(data) {
        console.log("Nuovo messaggio ricevuto: ", data);  // Log per verificare l'arrivo del messaggio
        const messagesContainer = document.getElementById('messages');
        messagesContainer.insertAdjacentHTML('beforeend', data.message);

        messagesContainer.scrollTop = messagesContainer.scrollHeight;
      }
    });
  }
});





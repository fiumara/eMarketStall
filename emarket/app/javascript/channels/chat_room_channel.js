import consumer from "./consumer";

document.addEventListener("turbolinks:load", () => {
  const chatRoomElement = document.getElementById("chat-room");
  if (!chatRoomElement) return;

  const chatRoomId = chatRoomElement.dataset.chatRoomId;

  consumer.subscriptions.create(
    { channel: "ChatRoomChannel", chat_id: chatRoomId },
    {
      received(data) {
        // Aggiungi il messaggio al contenitore della chat
        const messagesContainer = document.getElementById("messages");
        messagesContainer.insertAdjacentHTML("beforeend", data);
        messagesContainer.scrollTop = messagesContainer.scrollHeight;
      },
    }
  );
});

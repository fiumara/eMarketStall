import consumer from "./consumer";

document.addEventListener("turbolinks:load", () => {
  const chatRoomElement = document.getElementById("chat-room");
  if (!chatRoomElement) return;

  const chatRoomId = chatRoomElement.dataset.chatRoomId;

  const subscription = consumer.subscriptions.create(
    { channel: "ChatRoomChannel", chat_id: chatRoomId },
    {
      received(data) {
        // Aggiorna solo il contenitore della chat
        const messagesContainer = document.getElementById("messages");
        
        // Aggiungi il messaggio ricevuto
        messagesContainer.insertAdjacentHTML("beforeend", data.message_html);
        
        // Scorri in basso automaticamente
        messagesContainer.scrollTop = messagesContainer.scrollHeight;
      },
    }
  );

  // Aggiungi la possibilità di inviare messaggi tramite il pulsante 
  const messageInput = document.getElementById("message_input");
  const sendButton = document.getElementById("send_message_button");

  const sendMessage = () => {
    const message = messageInput.value.trim();
    if (message === "") return;

    subscription.perform("speak", { message });
    messageInput.value = ""; // Resetta il campo di input
  };

  sendButton.addEventListener("click", sendMessage);
  messageInput.addEventListener("keypress", (e) => {
    if (e.key === "Enter") {
      e.preventDefault();
      sendMessage();
    }
  });
});

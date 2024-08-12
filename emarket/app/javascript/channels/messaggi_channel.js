import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {
  const userIdElement = document.getElementById('user-id');
  
  if (userIdElement) {
    const userId = userIdElement.dataset.userId;
    const userType = userIdElement.dataset.userType;

    consumer.subscriptions.create({ channel: "MessaggiChannel", user_id: userId, user_type: userType }, {
      received(data) {
        const messagesContainer = document.getElementById('messages');
        if (messagesContainer) {
          messagesContainer.insertAdjacentHTML('beforeend', `<p>${data.contenuto}</p>`);
        }
      }
    });
  }
});

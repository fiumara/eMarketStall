class MessageChannel < ApplicationCable::Channel
  def subscribed
    # Subscrive l'utente a uno specifico canale (es. chat room)
    stream_from "message_channel_#{params[:chat_id]}"
  end

  def unsubscribed
    # Qualsiasi logica quando l'utente si disconnette
  end

  def speak(data)
    # Questo metodo riceve i dati dal client e crea un nuovo messaggio
    Message.create!(content: data['message'], user_id: current_user.id, chat_id: params[:chat_id])
  end
end


class AddVisibilityToChatRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :chat_rooms, :mittente_visible, :boolean, default: true
    add_column :chat_rooms, :destinatario_visible, :boolean, default: true
  end
end

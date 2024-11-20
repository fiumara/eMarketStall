class CreateChatRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :chat_rooms do |t|
      t.string :nome

      t.references :mittente, polymorphic: true, null: false
      t.references :destinatario, polymorphic: true, null: false

      t.timestamps
    end
  end
end

class CreateMessaggi < ActiveRecord::Migration[6.1]
  def change
    create_table :messaggi do |t|
      t.text :contenuto
      t.references :chat_room, null: false, foreign_key: { on_delete: :cascade }

      # Polymorphic associations for mittente and destinatario
      t.references :mittente, polymorphic: true, null: false
      t.references :destinatario, polymorphic: true, null: false

      t.timestamps
    end
  end
end


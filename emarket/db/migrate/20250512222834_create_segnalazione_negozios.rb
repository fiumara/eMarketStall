class CreateSegnalazioneNegozios < ActiveRecord::Migration[6.1]
  def change
    create_table :segnalazione_negozios do |t|
      t.string :motivo
      t.text :note
      t.references :acquirente, null: false, foreign_key: true
      t.references :negozio, null: false, foreign_key: true

      t.timestamps
    end
  end
end

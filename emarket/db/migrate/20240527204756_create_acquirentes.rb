class CreateAcquirentes < ActiveRecord::Migration[6.1]
  def change
    create_table :acquirentes do |t|
      t.string :nome
      t.string :cognome
      t.string :telefono
      t.string :nome_utente

      t.timestamps
    end
  end
end

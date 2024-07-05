class CreateResos < ActiveRecord::Migration[6.1]
  def change
    create_table :resos do |t|
      t.string :nome_prodotto
      t.string :nome_acquirente
      t.string :id_ordine
      t.text :motivazione_reso
      t.date :data_reso
      t.string :stato
      t.text :note_acquirente

      t.timestamps
    end
  end
end

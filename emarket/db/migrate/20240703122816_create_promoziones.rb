class CreatePromoziones < ActiveRecord::Migration[6.1]
  def change
    create_table :promoziones do |t|
      t.string :nome
      t.text :descrizione
      t.datetime :inizio
      t.datetime :fine
      t.decimal :sconto
      t.string :tipo
      t.references :prodotto, foreign_key: true
      t.references :categorium, foreign_key: true
      t.references :negozio, foreign_key: true
      t.string :created_by, null: false

      t.timestamps
    end
  end
end

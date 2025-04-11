class CreatePromoziones < ActiveRecord::Migration[6.1]
  def change
    create_table :promoziones do |t|
      t.string :nome
      t.text :descrizione
      t.datetime :inizio
      t.datetime :fine
      t.decimal :sconto
      t.string :tipo
      t.references :prodotto, foreign_key: { on_delete: :cascade }
      t.references :categorium, foreign_key: { on_delete: :cascade }
      t.references :negozio, foreign_key: { on_delete: :cascade }
      t.string :created_by, null: false

      t.timestamps
    end
  end
end

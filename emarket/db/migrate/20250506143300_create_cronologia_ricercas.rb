class CreateCronologiaRicercas < ActiveRecord::Migration[6.1]
  def change
    create_table :cronologia_ricercas do |t|
      t.references :acquirente, null: false, foreign_key:{on_delete: :cascade}
      t.references :prodotto, null: false, foreign_key:{on_delete: :cascade}

      t.timestamps
    end
  end
end

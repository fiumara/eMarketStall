class CreateCronologiaRicercas < ActiveRecord::Migration[6.1]
  def change
    create_table :cronologia_ricercas do |t|
      t.references :acquirente, null: false, foreign_key: true
      t.references :prodotto, null: false, foreign_key: true

      t.timestamps
    end
  end
end

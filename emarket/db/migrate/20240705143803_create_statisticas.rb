class CreateStatisticas < ActiveRecord::Migration[6.1]
  def change
    create_table :statisticas do |t|
      t.references :prodotto, null: false, foreign_key: { on_delete: :cascade }
      t.integer :visualizzazioni
      t.integer :vendite

      t.timestamps
    end
  end
end

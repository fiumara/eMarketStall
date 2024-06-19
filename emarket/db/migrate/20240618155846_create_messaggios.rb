class CreateMessaggios < ActiveRecord::Migration[6.1]
  def change
    create_table :messaggios do |t|
      t.string :nome_utente
      t.string :tipo_utente
      t.text :contenuto

      t.timestamps
    end
  end
end

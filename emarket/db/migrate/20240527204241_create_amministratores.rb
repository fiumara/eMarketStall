class CreateAmministratores < ActiveRecord::Migration[6.1]
  def change
    create_table :amministratores do |t|
      t.string :nome
      t.string :cognome
      t.string :telefono
      t.integer :id_amministratore

      t.timestamps
    end
  end
end

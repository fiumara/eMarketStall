class CreateAmministratores < ActiveRecord::Migration[6.1]
  def change
    create_table :amministratores, id: :uuid do |t|
      t.string :nome
      t.string :cognome
      t.string :telefono

      t.timestamps
    end
  end
end

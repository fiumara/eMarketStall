class CreateAmministratores < ActiveRecord::Migration[6.1]
  def change
    create_table :amministratores, id: false do |t|
      t.integer :id, primary_key:true
      t.string :email
      t.string :password_digest
      t.string :nome
      t.string :cognome
      t.string :telefono
      
      t.timestamps
    end
  end
end
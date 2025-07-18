class CreateAcquirentes < ActiveRecord::Migration[6.1]
  def change
    create_table :acquirentes, id: false do |t|
      t.integer :id, primary_key:true
      t.string :email
      t.string :password_digest
      t.string :nome
      t.string :cognome
      t.string :telefono
      t.string :nome_utente
      
      t.timestamps
    end
  end
end
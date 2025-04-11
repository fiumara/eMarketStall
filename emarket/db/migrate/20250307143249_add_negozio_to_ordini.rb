class AddNegozioToOrdini < ActiveRecord::Migration[6.1]
  def change
    add_reference :ordini, :negozio, foreign_key:  { on_delete: :nullify }
  end
end
class AddNegozioToOrdini < ActiveRecord::Migration[6.1]
  def change
    add_reference :ordini, :negozio, foreign_key: true
  end
end
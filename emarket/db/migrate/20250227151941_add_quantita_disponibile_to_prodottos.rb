class AddQuantitaDisponibileToProdottos < ActiveRecord::Migration[6.1]
  def change
    add_column :prodottos, :quantita_disponibile, :integer
  end
end

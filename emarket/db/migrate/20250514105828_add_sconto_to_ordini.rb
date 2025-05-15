class AddScontoToOrdini < ActiveRecord::Migration[6.1]
  def change
    add_column :ordini, :sconto, :decimal, precision: 10, scale: 2, default: 0.0
  end
end


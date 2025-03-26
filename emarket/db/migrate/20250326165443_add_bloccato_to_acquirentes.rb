class AddBloccatoToAcquirentes < ActiveRecord::Migration[6.1]
  def change
    add_column :acquirentes, :bloccato, :boolean, default: false
  end
end

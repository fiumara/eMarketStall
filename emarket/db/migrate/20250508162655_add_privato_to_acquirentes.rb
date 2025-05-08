class AddPrivatoToAcquirentes < ActiveRecord::Migration[6.1]
  def change
    add_column :acquirentes, :privato, :boolean
  end
end

class AddPuntiToAcquirentes < ActiveRecord::Migration[6.1]
  def change
    add_column :acquirentes, :punti, :integer, default: 0
  end
end

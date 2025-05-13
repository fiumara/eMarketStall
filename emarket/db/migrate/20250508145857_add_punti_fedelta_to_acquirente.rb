class AddPuntiFedeltaToAcquirente < ActiveRecord::Migration[6.1]
  def change
    add_column :acquirentes, :punti_fedelta, :integer, defaulte: 0
  end
end

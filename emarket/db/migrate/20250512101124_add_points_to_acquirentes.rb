class AddPointsToAcquirentes < ActiveRecord::Migration[6.1]
  def change
    add_column :acquirentes, :points, :integer, default: 0
    end
end

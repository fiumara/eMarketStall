class AddResetToAcquirentes < ActiveRecord::Migration[6.1]
  def change
    add_column :acquirentes, :reset_digest, :string
    add_column :acquirentes, :reset_sent_at, :datetime
  end
end

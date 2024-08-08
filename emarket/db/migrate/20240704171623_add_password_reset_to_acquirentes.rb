class AddPasswordResetToAcquirentes < ActiveRecord::Migration[6.1]
  def change
    add_column :acquirentes, :password_reset_token, :string
    add_column :acquirentes, :password_reset_sent_at, :datetime
  end
end

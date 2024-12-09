class AddGoogleFieldsToAcquirentes < ActiveRecord::Migration[6.1]
  def change
    add_column :acquirentes, :id_acquirente, :string
    add_column :acquirentes, :image_url, :string
  end
end

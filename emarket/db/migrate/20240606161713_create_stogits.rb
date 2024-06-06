class CreateStogits < ActiveRecord::Migration[6.1]
  def change
    create_table :stogits do |t|
      t.string :add
      t.string :.

      t.timestamps
    end
  end
end

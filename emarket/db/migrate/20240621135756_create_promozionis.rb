class CreatePromozionis < ActiveRecord::Migration[6.1]
  def change
    create_table :promozionis do |t|

      t.timestamps
    end
  end
end

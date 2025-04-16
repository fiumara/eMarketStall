class AddSegnalatoToFeedbacks < ActiveRecord::Migration[6.1]
  def change
    add_column :feedbacks, :segnalato, :boolean, default: false
  end
end

class ChangeMeetings < ActiveRecord::Migration[5.1]
  def change
    change_column :meetings, :topic, :text, null: true
    change_column :meetings, :sp_lead_qualification, :text, null: true
  end
end

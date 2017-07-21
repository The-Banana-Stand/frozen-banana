class AddFieldsToMeetings < ActiveRecord::Migration[5.1]
  def change
    add_column :meetings, :topic, :text
    add_column :meetings, :sp_lead_qualification, :text

    change_column_null(:meetings, :topic, false, 'empty' )
    change_column_null(:meetings, :sp_lead_qualification, false, 'empty' )

  end
end

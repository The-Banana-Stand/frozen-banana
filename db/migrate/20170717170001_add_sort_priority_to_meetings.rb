class AddSortPriorityToMeetings < ActiveRecord::Migration[5.1]
  def change
    add_column :meetings, :sort_priority, :integer
  end
end

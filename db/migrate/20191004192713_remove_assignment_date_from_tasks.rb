class RemoveAssignmentDateFromTasks < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :assignment_date
  end
end

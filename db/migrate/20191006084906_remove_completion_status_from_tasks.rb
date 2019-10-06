class RemoveCompletionStatusFromTasks < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :completion_status
  end
end

class ChangeCompletionFieldInTasks < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :completion_date
    add_column :tasks, :completed, :boolean
  end
end

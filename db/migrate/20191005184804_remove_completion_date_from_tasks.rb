class RemoveCompletionDateFromTasks < ActiveRecord::Migration[6.0]
  def change

    remove_column :tasks, :completion_date, :date
  end
end

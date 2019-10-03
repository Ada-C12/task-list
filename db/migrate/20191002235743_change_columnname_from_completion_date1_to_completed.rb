class ChangeColumnnameFromCompletionDate1ToCompleted < ActiveRecord::Migration[5.2]
  def change
    rename_column("tasks", :completion_date1, :completed)
  end
end

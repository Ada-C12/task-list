class AddTaskCompletionDate < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :completion_date, :date
  end
end

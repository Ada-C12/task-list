class EditTaskCompletionDate < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :date
    remove_column :tasks, :completion_date
  end
end

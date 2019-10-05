class AddCompletionDateToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :completion_date, :datetime
  end
end

class AddCompletionDatetimeToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :completion_datetime, :datetime
  end
end

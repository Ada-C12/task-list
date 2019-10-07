class ChangeCompletionDateToTimeInTask < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :completion_date, :date
    add_column :tasks, :completion_date, :time
  end
end

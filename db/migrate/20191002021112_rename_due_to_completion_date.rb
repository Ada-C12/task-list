class RenameDueToCompletionDate < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :due, :completion_date
  end
end

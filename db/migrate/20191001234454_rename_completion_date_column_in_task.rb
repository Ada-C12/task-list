class RenameCompletionDateColumnInTask < ActiveRecord::Migration[5.2]
  def change
    rename_column(:tasks, :completion_date, :due_date)
  end
end

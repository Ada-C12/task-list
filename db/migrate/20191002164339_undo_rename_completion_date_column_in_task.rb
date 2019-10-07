class UndoRenameCompletionDateColumnInTask < ActiveRecord::Migration[5.2]
  def change
    rename_column(:tasks, :due_date, :completion_date)
  end
end

class RenameDueDateColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column(:tasks, :due_date, :completed)
  end
end

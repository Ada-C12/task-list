class RenameDateTitle < ActiveRecord::Migration[5.2]
  def change
    rename_column(:tasks, :date, :due_date)

  end
end

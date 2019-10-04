class AddDueDateColumnWithNewDatatype < ActiveRecord::Migration[5.2]
  def change
    add_column(:tasks, :due_date, :time)
  end
end

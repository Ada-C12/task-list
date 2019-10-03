class AddNewCompletedColumn < ActiveRecord::Migration[5.2]
  def change
    add_column("tasks", :completed, :timestamp)
  end
end

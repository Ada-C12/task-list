class ChangeColumnCompleted < ActiveRecord::Migration[5.2]
  def change
    change_column("tasks", :completed, :timestamp)
  end
end

class FixingForTestMatching < ActiveRecord::Migration[5.2]
  def change
    remove_column("tasks", :completed)
    rename_column("tasks", :completion_date2, :completed)
    change_column("tasks", :completed, :timestamp)
  end
end

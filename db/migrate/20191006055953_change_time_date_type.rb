class ChangeTimeDateType < ActiveRecord::Migration[5.2]
  def change
    remove_column("tasks", :created_at)
    remove_column("tasks", :updated_at)
    remove_column("tasks", :completed)
    add_column("tasks", :completed, :timestamp)
  end
end

class RemoveCompletedAtFromTasks < ActiveRecord::Migration[6.0]
  def change

    remove_column :tasks, :completed_at, :datetime
  end
end

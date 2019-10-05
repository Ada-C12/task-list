class AddCompletedSecondTryToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :completed, :datetime
  end
end

class ChangeCompletionDateDataTypeAgain < ActiveRecord::Migration[5.2]
  def change
    remove_column(:tasks, :completion_date)
    add_column(:tasks, :completed, :datetime)
  end
end

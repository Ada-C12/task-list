class ChangeCompletionDateType < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :completion_date, :date
    add_column :tasks, :completion_date, :datetime
  end
end

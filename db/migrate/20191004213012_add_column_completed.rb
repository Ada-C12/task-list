class AddColumnCompleted < ActiveRecord::Migration[5.2]
  def change
    add_column(:tasks, :completed, :date)

  end
end

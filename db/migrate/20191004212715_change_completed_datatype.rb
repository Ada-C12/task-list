class ChangeCompletedDatatype < ActiveRecord::Migration[5.2]
  def change
    change_column(:tasks, :completed, :time)
  end
end

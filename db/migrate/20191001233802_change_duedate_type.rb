class ChangeDuedateType < ActiveRecord::Migration[5.2]
  def change
    remove_column(:tasks, :due_date)
  end
end

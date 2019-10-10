class AddCheckBox < ActiveRecord::Migration[5.2]
  def change
    rename_column(:tasks, :completion, :completed)
    # change_column(:tasks, :completed, :time)
  end
end

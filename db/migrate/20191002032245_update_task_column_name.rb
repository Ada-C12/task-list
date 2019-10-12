class UpdateTaskColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column(:tasks, :to_do, :name)
  end
end

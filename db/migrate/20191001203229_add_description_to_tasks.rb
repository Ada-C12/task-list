class AddDescriptionToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :description, :string
    add_column :tasks, :completed, :string
    rename_column :tasks, :to_do, :name
  end
end

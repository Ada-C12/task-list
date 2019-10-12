class AddDisplayDateToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :display_date, :string
  end
end

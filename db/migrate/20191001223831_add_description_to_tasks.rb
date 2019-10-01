class AddDescriptionToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :name, :description, :completion_date
  end
end

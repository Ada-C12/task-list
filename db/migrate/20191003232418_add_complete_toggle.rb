class AddCompleteToggle < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :toggle_complete, :boolean
  end
end

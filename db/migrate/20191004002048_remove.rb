class Remove < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :toggle_complete, :boolean
  end
end

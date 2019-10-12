class RemoveDisplayDate < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :display_date
  end
end

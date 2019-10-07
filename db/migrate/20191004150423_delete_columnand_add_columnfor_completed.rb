class DeleteColumnandAddColumnforCompleted < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :completion
    add_column :tasks, :completed, :timestamp   
  end
end

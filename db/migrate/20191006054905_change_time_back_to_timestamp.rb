class ChangeTimeBackToTimestamp < ActiveRecord::Migration[5.2]
  def change
    remove_column("tasks", :completed)
    add_column("tasks", :completed, :timestamp, default: Time.zone.now)
  end
end

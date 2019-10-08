class ChangeDatatypeToTime < ActiveRecord::Migration[5.2]
  def change
    change_column("tasks", :completed, :string)
  end
end

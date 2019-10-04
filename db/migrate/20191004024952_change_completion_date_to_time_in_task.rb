class ChangeCompletionDateToTimeInTask < ActiveRecord::Migration[5.2]
  def change
    change_column :hike, :completion_date, :time
  end
end

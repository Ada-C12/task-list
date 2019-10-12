class CompletionDateDatatypeToTime < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :completion_date, :time
  end
end

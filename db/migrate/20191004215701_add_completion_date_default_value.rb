class AddCompletionDateDefaultValue < ActiveRecord::Migration[5.2]
  def change
    change_column(:tasks, :completion_date, :datetime, :default => nil)
  end
end

class UpdateCompletionColumnDataType < ActiveRecord::Migration[5.2]
  def change
    change_column(:tasks, :completed, :string)
    # rename_column(:tasks, :completed, :completed)
  end
end

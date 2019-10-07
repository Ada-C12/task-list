class AddsCompletedTime < ActiveRecord::Migration[5.2]
  def change
    add_column(:tasks, :completed, :time)
  end
end

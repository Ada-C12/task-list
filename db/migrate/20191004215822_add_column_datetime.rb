class AddColumnDatetime < ActiveRecord::Migration[5.2]
  def change
    add_column(:tasks, :completed, :datetime)
  end
end

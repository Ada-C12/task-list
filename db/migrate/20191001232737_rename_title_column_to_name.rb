class RenameTitleColumnToName < ActiveRecord::Migration[5.2]
  def change
    rename_column(:tasks, :title, :name)
  end
end

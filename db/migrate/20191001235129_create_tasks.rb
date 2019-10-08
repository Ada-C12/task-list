class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.string :completion_date1
      t.date :completion_date2

      t.timestamps
    end
  end
end

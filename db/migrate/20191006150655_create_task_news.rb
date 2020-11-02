class CreateTaskNews < ActiveRecord::Migration[5.2]
  def change
    create_table :task_news do |t|
      t.string :name
      t.string :description
      t.datetime :completed

      t.timestamps
    end
  end
end

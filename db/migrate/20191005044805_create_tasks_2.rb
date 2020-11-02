class CreateTasks2 < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.time :completion
      
      t.timestamps
    end
  end
end

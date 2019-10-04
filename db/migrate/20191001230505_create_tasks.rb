class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.integer :completion
      
      t.timestamps
    end
  end
end


# rails generate migration 
# remove_column :tasks, :completion
# add_column :tasks, :completed, :timestamp

# remove column, add column in migration
# drop column
# change headers 

# update to completed in seeds 


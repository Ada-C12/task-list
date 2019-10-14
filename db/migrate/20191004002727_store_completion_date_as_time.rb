class StoreCompletionDateAsTime < ActiveRecord::Migration[5.2]
  def change
    def up
      change_column :tasks, :completion_date, :time
    end
    
    def down
      change_column :tasks, :completion_date, :datetime
    end
  end
end

class ChangeCompleteionDateToDateType < ActiveRecord::Migration[5.2]
  def change
    execute 'ALTER TABLE tasks ALTER completion_date TYPE date USING completion_date::date'
  end
end

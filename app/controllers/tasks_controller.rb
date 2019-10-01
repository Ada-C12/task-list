# TASKS = [
#   { name: "Study", description: "Finish Wave 4 homework", completion_date: nil},
#   { name: "Clean house", description: "Sweep and mop the floors", completion_date: nil},
#   { name: "Buy groceries", description: "Buy all of trader joes", completion_date: nil}
# ]

class TasksController < ApplicationController
  
  def index
    @tasks = Task.all
  end
  
  def show
    task_id = params[:id]
    @task = Task.find_by[id:task_id]
    
    if @task.nil?
      head :not_found
      return
    end
  end
  
end
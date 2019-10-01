TASKS = [
  { task: "Study", description: "Finish Wave 4 homework", completion_date: "5 days"},
  { task: "Clean house", description: "Sweep and mop the floors", completion_date: "3 days"},
  { task: "Buy groceries", description: "Buy all of trader joes", completion_date: "6 days"}
]

class TasksController < ApplicationController
  
  def index
    @tasks = TASKS
  end
  
  def show
    task_id = params[:id].to_i
    @task = TASKS[task_id]
    
    if @task.nil?
      head :not_found
      return
    end
  end
  
end
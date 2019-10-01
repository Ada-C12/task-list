TASKS = [
  { task: "Study", description: "Finish Wave 4 homework"},
  { task: "Clean house", description: "Sweep and mop the floors"},
  { task: "Buy groceries", description: "Buy all of trader joes"}
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
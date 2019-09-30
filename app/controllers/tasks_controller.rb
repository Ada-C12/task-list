TASKS = [
  { name: "Task 1", description: "Do my homework"},
  { name: "Task 2", description: "Prepare my lunch"},
  { name: "Task 3", description: "Get the groceries"}
]

class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end

  def show
    task_id = params[:id].to_i
    @task = TASK[task_id]
    
    if @task.nil?
      head :not_found
      return
    
end

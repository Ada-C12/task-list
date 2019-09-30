TASKS = [
{ task: "Pay Rent", description: "$2,100, Send Check by the First"},
{ task: "Donate Items", description: "Deliver to Goodwill in Ballard"},
{ task: "Send Thank You", description: "Mail Card by Friday"}
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

TASKS = ["Laundry", "Feed Babette", "Clean room", "Sleep"] 
class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end
  
  def show
    task_id = params[:index].to_i
    @task = Task.find(index: task_id)
    if @task.nil?
      head :not_found
      return
    end
  end
end
  
# def show
#   task_id = params[:index].to_i
#   @task = TASKS[task_id]
#   if @task.nil?
#     head :not_found
#     return
#   end
# end
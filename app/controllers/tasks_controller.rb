# TASKS = ["Get groceries", "Clean kitchen", "Read about rails", "Do laundry"]

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end 
end

def show
  task_id = params[:id]
  @task = Task.find_by(id: task_id)
  
  if @task.nil?
    head :not_found
    return
  end
end

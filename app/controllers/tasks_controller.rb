class TasksController < ApplicationController
  
  TASKS = Task.all
  
  def index
    @greeting = "HELLO, THERE!"
    @tasks = TASKS
  end
  
  def show
    @tasks = TASKS
    @task_id = params[:id].to_i
    @task = @tasks.find_by(id: @task_id)
    if @task.nil?
      head :not_found
      return
    end
  end
  
end

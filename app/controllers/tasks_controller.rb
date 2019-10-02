class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  
  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    
    if @task.nil?
      redirect_to root_path, flash: { error: "Could not find task with id: -1" }
      return
    end
  end
end

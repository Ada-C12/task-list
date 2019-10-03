class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  
  def show
    task_id = params[:id]
    @task = Task.find_by(id: task_id)
    
    if @task.nil?
      redirect_to root_path, flash: { error: "Could not find task with id: #{task_id}" }
      return
    end
  end
  
  def new
    @task = Task.new
  end
  
end

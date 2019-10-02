

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  
  def show
    task_id = params[:id].to_i
    @tasks = Task.find_by(id:task_id)
    if @tasks.nil?
      head :not_found
      return
    end
  end
  
  def new
    @task = Task.new
  end
  
  def create
    task_params = params[:task]
    task = Task.new(name: task_params[:name], description: task_params[:description])
    task.save
    
    redirect_to tasks_path
  end
  
end

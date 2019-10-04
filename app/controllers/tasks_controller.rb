class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end
  
  def show
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)
    if @task.nil?
      redirect_to tasks_path
      return
    end
  end
  
  def new
    @task = Task.new
    @task.name = "A very important task"
    @task.description = "Very important details"
  end
  
  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description])
    
    if @task.save
      redirect_to task_path(@task.id)
    else
      render new_task_path
    end
  end
end
